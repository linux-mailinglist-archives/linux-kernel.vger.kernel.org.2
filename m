Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF9E38A068
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhETI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:59:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58953 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhETI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:59:43 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ljeVZ-0003n1-Sr; Thu, 20 May 2021 08:58:21 +0000
From:   Colin Ian King <colin.king@canonical.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: ALSA: usb-audio: Handle error for the current selector gracefully
 [ uninitialized variable issue ]
Message-ID: <4b261d68-f53f-240d-2d8a-2f88b337849d@canonical.com>
Date:   Thu, 20 May 2021 09:58:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with Coverity on linux-next has detected an
uninitialized variable issue with the following commit:

commit 481f17c41803985446fd12887b2c042f9c43b0d5
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue May 18 17:21:12 2021 +0200

    ALSA: usb-audio: Handle error for the current selector gracefully

The branching is a bit convoluted and we end up with variable cur not
being initialized. Analysis is as follows:

254static int __uac_clock_find_source(struct snd_usb_audio *chip,
255                                   const struct audioformat *fmt, int
entity_id,
256                                   unsigned long *visited, bool validate)
257{
258        union uac23_clock_source_desc *source;
259        union uac23_clock_selector_desc *selector;
260        union uac23_clock_multiplier_desc *multiplier;

   1. var_decl: Declaring variable cur without initializer.

261        int ret, i, cur, err, pins, clock_id;
262        const u8 *sources;
263        int proto = fmt->protocol;
264
265        entity_id &= 0xff;
266

   2. Condition test_and_set_bit(entity_id, visited), taking false
branch.

267        if (test_and_set_bit(entity_id, visited)) {
268                usb_audio_warn(chip,
269                         "%s(): recursive clock topology detected, id
%d.\n",
270                         __func__, entity_id);
271                return -EINVAL;
272        }
273
274        /* first, see if the ID we're looking for is a clock source
already */
275        source = snd_usb_find_clock_source(chip, entity_id, proto);

   3. Condition source, taking false branch.

276        if (source) {
277                entity_id = GET_VAL(source, proto, bClockID);
278                if (validate && !uac_clock_source_is_valid(chip, fmt,
279
entity_id)) {
280                        usb_audio_err(chip,
281                                "clock source %d is not valid, cannot
use\n",
282                                entity_id);
283                        return -ENXIO;
284                }
285                return entity_id;
286        }
287
288        selector = snd_usb_find_clock_selector(chip, entity_id, proto);

   4. Condition selector, taking true branch.
289        if (selector) {
   5. Condition proto == 48, taking true branch.
290                pins = GET_VAL(selector, proto, bNrInPins);
   6. Condition proto == 48, taking true branch.
291                clock_id = GET_VAL(selector, proto, bClockID);
   7. Condition proto == 48, taking true branch.
292                sources = GET_VAL(selector, proto, baCSourceID);
293
   8. Condition pins == 1, taking false branch.

294                if (pins == 1) {
295                        ret = 1;
296                        goto find_source;
297                }
298
299                /* the entity ID we are looking for is a selector.
300                 * find out what it currently selects */
301                ret = uac_clock_selector_get_val(chip, clock_id);

   9. Condition ret < 0, taking true branch.

302                if (ret < 0) {

   10. Condition !chip->autoclock, taking false branch.

303                        if (!chip->autoclock)
304                                return ret;

   11. Jumping to label find_others.

305                        goto find_others;
306                }
307
308                /* Selector values are one-based */
309
310                if (ret > pins || ret < 1) {
311                        usb_audio_err(chip,
312                                "%s(): selector reported illegal
value, id %d, ret %d\n",
313                                __func__, clock_id, ret);
314
315                        if (!chip->autoclock)
316                                return -EINVAL;
317                        ret = 0;
318                        goto find_others;
319                }
320
321        find_source:
322                cur = ret;
323                ret = __uac_clock_find_source(chip, fmt,
324                                              sources[ret - 1],
325                                              visited, validate);
326                if (ret > 0) {
327                        err = uac_clock_selector_set_val(chip,
entity_id, cur);
328                        if (err < 0)
329                                return err;
330                }
331
332                if (!validate || ret > 0 || !chip->autoclock)
333                        return ret;
334
335        find_others:
336                /* The current clock source is invalid, try others. */
   12. Condition i <= pins, taking true branch.
337                for (i = 1; i <= pins; i++) {

Uninitialized scalar variable (UNINIT)

   13. uninit_use: Using uninitialized value cur.

338                        if (i == cur)
339                                continue;
340

Colin

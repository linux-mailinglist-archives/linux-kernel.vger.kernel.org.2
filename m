Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65C350322
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhCaPRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:17:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57266 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhCaPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:17:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lRcay-0003ue-RA; Wed, 31 Mar 2021 15:17:24 +0000
To:     Jaroslav Kysela <perex@perex.cz>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: ALSA: control - add layer registration routines
Cc:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <96e9bd5c-c8db-0db8-b393-fbf4a047dc80@canonical.com>
Date:   Wed, 31 Mar 2021 16:17:24 +0100
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

Static analysis on linux-next with Coverity has detected a potential
issue in the following commit:

commit 3f0638a0333bfdd0549985aa620f2ab69737af47
Author: Jaroslav Kysela <perex@perex.cz>
Date:   Wed Mar 17 18:29:41 2021 +0100

    ALSA: control - add layer registration routines

The static analysis is as follows:

2072 void snd_ctl_disconnect_layer(struct snd_ctl_layer_ops *lops)
2073 {
2074        struct snd_ctl_layer_ops *lops2, *prev_lops2;
2075
2076        down_write(&snd_ctl_layer_rwsem);

    assignment: Assigning: prev_lops2 = NULL.

2077        for (lops2 = snd_ctl_layer, prev_lops2 = NULL; lops2; lops2
= lops2->next)
2078                if (lops2 == lops) {

    null: At condition prev_lops2, the value of prev_lops2 must be NULL.
    dead_error_condition: The condition !prev_lops2 must be true.

2079                        if (!prev_lops2)
2080                                snd_ctl_layer = lops->next;
2081                        else

    'Constant' variable guards dead code (DEADCODE) dead_error_line:
    Execution cannot reach this statement: prev_lops2->next = lops->next;.
    Local variable prev_lops2 is assigned only once, to a constant
value, making it effectively constant throughout its scope. If this is
not the intent, examine the logic to see if there is a missing
assignment that would make prev_lops2 not remain constant.

2082                                prev_lops2->next = lops->next;
2083                        break;
2084                }
2085        up_write(&snd_ctl_layer_rwsem);
2086 }

I couldn't quite figure out the original intent of the prev_lops use, so
I'd thought I'd report this issue as the code does look incorrect.

Colin

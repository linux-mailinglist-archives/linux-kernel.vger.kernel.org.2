Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3FF3C150B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhGHOWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:22:25 -0400
Received: from mout01.posteo.de ([185.67.36.65]:58317 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231965AbhGHOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:22:24 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DCF32240026
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 16:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1625753980; bh=zicqAZ7JeXd7r/KlOZ/IYGKV7jWtQKPpW8wVlrHAPAk=;
        h=Date:From:To:Cc:Subject:From;
        b=WxjSKTqUR7xy6oM1vaOAea2+dPNEvSlendQbrgf6nHGStZPPsNfzASNl7jjwSuwW1
         cUof0T60H6rAhG/5AX24QPAfXhBg8vS5V16XPhHj2nbGTuwGJup0z5sA0Uch/nFgNA
         5CP4lM51ZFQJqDB4uZmAGkEgGsOJ7czfkq8m/lU9lh8a+X65gDJdGU8UxUaaDts5TF
         HD85Xhz4hDlOJaTQDOGH0y9PAoVCQlwLpJkDtcDk0jhsxl6wQeUtkFGuQfreJX1xm/
         alYNCt+JyG2P3C/RKhKvDzgfhIr9xoEl0ju/LmP4gbgg06lFCp6jwwAljvGIXeEEMD
         lMGtZTGypTtLw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4GLJMc3yycz6tmG;
        Thu,  8 Jul 2021 16:19:40 +0200 (CEST)
Date:   Thu,  8 Jul 2021 14:19:35 +0000
From:   Julian Weigt <juw@posteo.de>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: BUG: cannot enable iso_layout with apple keyboard
Message-ID: <20210708141935.bx33mv2jxtm752z3@julianexternal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an apple keyboard model A1644 EMC 2815 with Finnish/Swedish ISO layout. When I connect it via cable it works fine. But when I connect it via bluetooth, then the buttons >/< and §/° are swapped. It seems to make no difference if I set iso_layout to 0 or to 1. I checked and it turns out that hid->country below equals 0, and removing the check

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 6b8f0d004d34..8a764ce4e518 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -267,13 +267,11 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
        }

        if (iso_layout) {
-               if (hid->country == HID_COUNTRY_INTERNATIONAL_ISO) {
                        trans = apple_find_translation(apple_iso_keyboard, usage->code);
                        if (trans) {
                                input_event(input, usage->type, trans->to, value);
                                return 1;
                        }
-               }
        }

        if (swap_opt_cmd) {

makes the buttons act correctly. Please let me know how I can help fixing this.

Best regards,
Julian Weigt

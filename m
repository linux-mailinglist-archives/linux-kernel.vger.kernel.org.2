Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD19F3EE6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbhHQGpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhHQGpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:45:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C50C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:44:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bo18so30672103pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rh78CCde9OfVGRpH7hH2HpmGlVIlBmH6EVTWdupki5c=;
        b=e6p9RpI6VmQyi4oFKGYGWa7qxP1kCOsCl2egCzzl9+sp3WWNjOVvTOS1BotE5XqLlh
         SJ1mjuxVi3++OOAAMUMYyZC52ydysfc7QK9ruXC3pBCotc8wtZSIQsaI1kI1UV9YdD3O
         iATj3EyKOsdCSyjSJDf23JDx6G08aM4G6ruOYZpyvNqt1Jqvb/nErrOIcIhgalnWDq5V
         91Or6kqKWeAI8bnRXMwb55diIzqW3HnZkeXWEf2GUhBzGKRhHfdhCYdVM2zmZYkjrlXU
         3WuvV6Fz5TmdX2DlEOlUHn3Mjb8HR90JAon3p8bWWMeMaLT5TLlAteZtk3ECSlQsp7V3
         aYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rh78CCde9OfVGRpH7hH2HpmGlVIlBmH6EVTWdupki5c=;
        b=FmAmsvvhUjB5vIjcYASLo9gQAbY6hgm0LKzTKxExVnGfabfMXuDaX2KP6bKx2cyzez
         O/PrcmQVQnbJfSw4J6a15QG6/gurjU4C+Cd4Qm5CFUnNApwm/U0bw4rIPJMzwzVkbX83
         WNOEXIdW1kPoz2goQD80iqsb4e+VOwRnRjW9IY7HLdNWAeTWhMJd53ffzQovwHnd7aSA
         ZQqYX7WIUeGyfTkJ34IoO2Q20j1IvnuGj0SLTksVoX5YYXKiuEuC2UoVkDOoIo5UOaPW
         1ku+OLywKTXX1iBwGxdUTfVM6S0dXFFXJnCpKyc4vndqy/tPscKoYv1h/COy5wcOlYBe
         cJWQ==
X-Gm-Message-State: AOAM533A0QswUXGKEf9T8iwfbnWu0xmt2rA0mXkT/ZmLnHUEE6OPSX7e
        +kW0gNSXbFqGI7PtSNf9LU5PFg==
X-Google-Smtp-Source: ABdhPJw6ubxHbWrC0nsiaRj+XZYqTkR1c1fqchC2dyK5OJJJk50DvxwLDKEa/v2UUtjIxizD06wyEQ==
X-Received: by 2002:a05:6a00:2142:b029:3b9:e5df:77ab with SMTP id o2-20020a056a002142b02903b9e5df77abmr2170557pfk.52.1629182697872;
        Mon, 16 Aug 2021 23:44:57 -0700 (PDT)
Received: from ubuntu ([106.245.77.4])
        by smtp.gmail.com with ESMTPSA id z2sm1758614pgz.43.2021.08.16.23.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 23:44:57 -0700 (PDT)
Date:   Tue, 17 Aug 2021 15:43:53 +0900
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     team-linux@rtst.co.kr, mkbyeon@lselectric.co.kr,
        khchoib@lselectric.co.kr
Subject: [PATCH v2] usb: chipidea: add loop timeout for hw_ep_set_halt()
Message-ID: <20210817064353.GA669425@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ctrl EP priming is failed (very rare case in standard linux),
hw_ep_set_halt goes infinite loop. waiting 100 times was enough
for zynq7000.

Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 8834ca613721..d73fadb18f32 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -209,6 +209,9 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
 	return 0;
 }
 
+/* enough for zynq7000 evaluation board */
+#define HW_EP_SET_HALT_COUNT_MAX 100
+
 /**
  * hw_ep_set_halt: configures ep halt & resets data toggle after clear (execute
  *                 without interruption)
@@ -221,6 +224,7 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
  */
 static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
 {
+	int count = HW_EP_SET_HALT_COUNT_MAX;
 	if (value != 0 && value != 1)
 		return -EINVAL;
 
@@ -232,9 +236,9 @@ static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
 		/* data toggle - reserved for EP0 but it's in ESS */
 		hw_write(ci, reg, mask_xs|mask_xr,
 			  value ? mask_xs : mask_xr);
-	} while (value != hw_ep_get_halt(ci, num, dir));
+	} while (value != hw_ep_get_halt(ci, num, dir) && --count > 0);
 
-	return 0;
+	return count ? 0 : -EAGAIN;
 }
 
 /**
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D459644035E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhJ2Tmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhJ2Tmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:42:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E9AC061570;
        Fri, 29 Oct 2021 12:40:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s13so10964252wrb.3;
        Fri, 29 Oct 2021 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vZm9A2T24RE3QB1vLk0UMA+gWOq1n7UkyGpi6SN/IHE=;
        b=YceGVtW30AVsOVXYivUXmm3i8/mNJJ0W8Ptgcrjp3qB/O4WwM1ITTAoczMwseKeeCg
         +vblbOi3NdZPcbhPrVNdKlChdv+z1F1G9AWJAzrBRP1IKZ25MiVpw+yKC4TZp9JZQMxG
         4m885QhW+uc93ulrTlxw6EwFcE8q7YMmKFfbzoHuCorXqsrBJbalVXn3H/E2euxWrOzz
         f8rICvbqVnOtZXEBtttifSE7ts42hcW51QIqp4HFHI5Q6YyeTNrAzhwAUdiwnUHGXDaf
         hr23zeqY/UCIehaxQOpU7TQTea2L2wY523VL+vbJ4sNM4wWzYNZRLoIbLNY4G8sZAWfN
         A5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vZm9A2T24RE3QB1vLk0UMA+gWOq1n7UkyGpi6SN/IHE=;
        b=JE8200Pyjfw91VNGwPHb01cKncYek/b4EUtBQQjHq0YiuI/LVxrfPz3ckFXoOmC1Gk
         R/QD5WDTDmePIUb9i77t5tRGUM3K2dhh5QeLdUZ9DJmRAAvNlXqr77E6nWnNGMuQLknH
         eJlFQbvh3jjRhhF21fcvBBAgWJz0TmHj9DVgR0c2S7j9FLQERdM/i9bpENdlH1cpTen0
         I+MHEDHy8tmAIqHs9NNW1LLJ/WtZaOxYr8wLAcQcNUlQFHBCPN7deowh3zDcRCr65UAC
         C/IV5ou9pSBrt/Tquzd/5jQx+F4cmYg3BiCoVK6pOcoB834VPKIogD8849HndZxm+wD6
         uF2w==
X-Gm-Message-State: AOAM532y/mK8SGbACn2YR6gm7wsM929X9M6zPRxnSTROfnnpraAkxIKf
        c7zGv1HDu9y+Y+jebbQGOaqKlfAfVVU=
X-Google-Smtp-Source: ABdhPJw4waE+VCdmq0wxVL12cUjBCge80VDwLXVAhr2BIkrGOhwQkVdh9gsLBhSWov95WOxTs3hTpg==
X-Received: by 2002:a05:600c:796:: with SMTP id z22mr13375932wmo.188.1635536400933;
        Fri, 29 Oct 2021 12:40:00 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06341d0f9ebdf4bbe019.dip0.t-ipconnect.de. [2003:c7:8f4e:634:1d0f:9ebd:f4bb:e019])
        by smtp.gmail.com with ESMTPSA id f7sm7668646wmg.14.2021.10.29.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:40:00 -0700 (PDT)
Date:   Fri, 29 Oct 2021 21:39:58 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 2/3] Docs: usb: update comment and code near increment usage
 count
Message-ID: <53328d28190d987dc0ac5b455014bfe32cf39a64.1635533924.git.philipp.g.hortmann@gmail.com>
References: <cover.1635533924.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635533924.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update comment: increment our usage count ..
and code according to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 5c29e5bdbe88..14eda0342649 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -167,8 +167,8 @@ structure. This is done so that future calls to file operations will
 enable the driver to determine which device the user is addressing. All
 of this is done with the following code::
 
-    /* increment our usage count for the module */
-    ++skel->open_count;
+    /* increment our usage count for the device */
+    kref_get(&dev->kref);
 
     /* save our object in the file's private structure */
     file->private_data = dev;
-- 
2.25.1


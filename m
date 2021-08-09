Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C573E3D79
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhHIBTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhHIBTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:19:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48193C061757;
        Sun,  8 Aug 2021 18:19:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d17so14622643plr.12;
        Sun, 08 Aug 2021 18:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qSsRfeOAJJimPe0eYAMPrHD413ivEpqTS/QEGrDm3js=;
        b=tzdhaor+KWi2luHy4aIsq/oDv7z6BnwlKGNnzFo54tohcAHzGG09bYbISDA29hVh5d
         utvwjNQc3vEasqddOcjEUciGzEzUhtPWG1STAMWffZdZpQpOLMguCTIV34+hCoUUWsK2
         GtWmjhK0m9VbuhSDUrLCS/plOAgsn9lNvVLv/3bj6BG1Asz8Lg5+w4Nu+vaFRGHRJuOt
         Ag9ZXoFGlvq0iVPlhPKPaH+hHo5lOWatwb9xciUsKf9NeI238oB10CmiCIBhshuBF6q9
         GfOVTLS2XbBQ7MfUhNUyYksA7VeLGBgO+2jpk0ObWd52x9o6niNu+dmUme7XTzd6pO7Y
         Zb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qSsRfeOAJJimPe0eYAMPrHD413ivEpqTS/QEGrDm3js=;
        b=iZkLOjBePo2PBQzM/PQXUstYa9EPm/DhrXm0JLU/ev/cjqVGTgbzSXLXTRxvh47JIk
         BLWB4t3jF0JxJfybE3AbVJVr7zlL+WI2Fmms4CwCHHgiiJctwWkpeZTwn62/bMtEnGs6
         onGyOpWT5Ibut3CnmXGQAgCXxLsSLqLFlChwQfsV6FzyxAVnyY9ytteAZyYMACMI15ig
         i98E67CgWx/iho/XmjT0RIh17zjdxY3f2NZ4BOUSp4hsrJ1KQBa+aPLkJnIcfD6rb+OP
         THW1qKW+ELSs/jA6ZO+Zoorgfc2wiAGGdA/YFiHtpe2HjZAL0GmTHt5sfyNY/r3oD45t
         utdg==
X-Gm-Message-State: AOAM532P5mM+msJ2e/IH/lqHH7EWf7oIXjf+DEM4dpLMVwJqwxUyJRR5
        KDJ0CTtsm9Zs80nob6mTaIw=
X-Google-Smtp-Source: ABdhPJwDWq6qqUtoCrPVMRIThw3Y8oif2IZPY6bP6brvW6y+ivxDA5o6j20MdJD5baBXqlPuahKPRg==
X-Received: by 2002:a17:90b:1882:: with SMTP id mn2mr33491627pjb.213.1628471967707;
        Sun, 08 Aug 2021 18:19:27 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p7sm7037839pfn.211.2021.08.08.18.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:19:27 -0700 (PDT)
Subject: [PATCH v4 4/9] docs: pdfdocs: Preserve inter-phrase space in Korean
 translations
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <68de2e52-e6d1-3f01-c097-15ba7b28a319@gmail.com>
Date:   Mon, 9 Aug 2021 10:19:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Korean typesetting, inter-phrase spaces in Hangul text have
a similar role as the the inter-word spaces in Latin text.
They can be preserved by the \xeCJKsetup{CJKspace=true} option.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 980be06df723..2ccfe4442acc 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -426,6 +426,7 @@ latex_elements['preamble']  += '''
 	    \\renewcommand{\\CJKrmdefault}{KRserif}%
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
 	    \\renewcommand{\\CJKttdefault}{KRmono}%
+	    \\xeCJKsetup{CJKspace = true} % For inter-phrase space
 	}
 	\\newcommand{\\kerneldocEndKR}{\\endgroup}
 	\\newcommand{\\kerneldocBeginJP}{%
-- 
2.17.1



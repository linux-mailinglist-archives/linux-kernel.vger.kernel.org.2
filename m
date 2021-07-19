Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9615C3CD3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhGSKfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhGSKfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:35:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA91C061574;
        Mon, 19 Jul 2021 03:26:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p9so11232231pjl.3;
        Mon, 19 Jul 2021 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xm5kZ9iiuiXOod5i9iz4p0syanKjvZYe/iVvk7lSJJU=;
        b=tqSrk1wiPDewm905DKY02ogzus7JCRYQy/0QA0RnUWEvuCqs7N22tdUMyUkdYRgWvg
         u8QycD8mOTdXPVmRajiZ4+w6jkFMX6BuhIN/k0PJJtLwSdGdI2p3G66EL4hS6ZMmntIW
         wfvwNrzHfWtai7K9W2oUzO61or2IDl/QCkLKdqop88GN04ZKd+uDC+PZ/SH9tNZZ55wo
         GFKjtMLYFJvcxh9vXeYKUcvs1w7yDi6DB2Oicz56QrvVcSBao37pkjBwcbVaJ8Jz9R9b
         BdPoIm75nuWUqIYOb56RmgjStrgMnzwHKG0Vx13JSMb3U7lBKI40PGUCXHC1eEw44ihr
         S/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xm5kZ9iiuiXOod5i9iz4p0syanKjvZYe/iVvk7lSJJU=;
        b=pMaxBetdDYu1ANu6UVcxhuEjZFqWHgpBIT60P+ayJtGkZXQW/2wXKkhIirK1J9Hvaz
         bkzrFelDnVJc83/r4pgBC0iKCvWv1P/NgWDbHd8J/kGomm1Z/Sz2Ed+K3lvYAQKgLNuR
         +wcLF0muzqpLrGFoSKYI5+UFfHuU63rJkm+ItivZ008Jne8I8Ga63pmA5k8QVvnFe4mp
         fQskxd/P4wmCh2QejZZblU6hkmaCIropIOi/wIcVNIHrIf0zQnOZfLHEbIQ5z9wKuKBv
         +WfcNBoiwgZ16tHejCY1z2b2niMJTD2BejxLKF6+zJeZplqnDZv/3FtiLTr+53yWviiw
         Awrg==
X-Gm-Message-State: AOAM533Wi0PxENtyxn6FWKF5ClUVyVsrbcEX2E7nvxGgEuPsIxHPm6di
        Lt4/d3mKRU5tpridjq2ua4k=
X-Google-Smtp-Source: ABdhPJx46sn8xwubJ0j4N8c5vGiVWmiEk0HyXI/C/Oj52qP7aO//sLHg3HOhQnO/QqOqyYO6a3bzsw==
X-Received: by 2002:a17:90b:ed2:: with SMTP id gz18mr29398587pjb.184.1626693348315;
        Mon, 19 Jul 2021 04:15:48 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e30sm22640597pga.63.2021.07.19.04.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 04:15:48 -0700 (PDT)
Subject: [RFC PATCH v2 5/7] docs: pdfdocs: Teach xeCJK the width of quotation
 marks
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>,
        Shinwoo Lee <shinwoo.lee.us@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <16d212cc-de0a-9259-6564-ce7431ed1f44@gmail.com>
Date:   Mon, 19 Jul 2021 20:15:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quotation marks in "Noto Serif CJK KR" and "Not Serif CJK JP" fonts
are half width.
xeCJK assumes they are full width as in "Noto Serif CJK SC" and are
confused by the KR/JP variants.

Give xeCJK the character-class hints by the \xeCJKDeclareCharClass
command.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 9a237471289b..8a715765dada 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -384,6 +384,8 @@ latex_elements['preamble']  +=3D '''
 	\\newcommand{\\kerneldocEndSC}{\\endgroup}
 	\\newcommand{\\kerneldocBeginKR}{%
 	    \\begingroup%
+	    \\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}%
+	    \\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}%
 	    \\krserif%
 	    \\renewcommand{\\CJKrmdefault}{KRserif}%
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
@@ -393,6 +395,8 @@ latex_elements['preamble']  +=3D '''
 	\\newcommand{\\kerneldocEndKR}{\\endgroup}
 	\\newcommand{\\kerneldocBeginJP}{%
 	    \\begingroup%
+	    \\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}%
+	    \\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}%
 	    \\jpserif%
 	    \\renewcommand{\\CJKrmdefault}{JPserif}%
 	    \\renewcommand{\\CJKsfdefault}{JPsans}%
--=20
2.17.1




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A83DD377
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhHBJ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbhHBJ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:59:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0092C06175F;
        Mon,  2 Aug 2021 02:59:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u2so10781068plg.10;
        Mon, 02 Aug 2021 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jxfTFqLhtIlxiaNew08jchvdKl6M0DzpVExA2LcES3Q=;
        b=WEqY5zs9FM3pLA5nkaxQZ98jHoCDSZ0kuut0FuB7sWeVY74erN2kZd8MyR8KEnUIFZ
         Mqw2b2s89F8qo8BPoHO8FIE3Y7H2xIJQuzgxRlDRFjX8x4FWfJV4OF5NCjBEfEzOW20i
         j8Hu9BBbIEapVLt9J2FIMZ1xllhJN9Qy1zxApoRrs4vLf432pnlNG2YZXUwlxikqO8Js
         DwdOtHVMbiehP/5NepyUcuYSQTFrIH3M4v+POmyREVIeh7jCqUAHijc+DzObBxqVpPC0
         SURn9ceC0v6xqkGEWLyJCKyXZHa18ANrr0N67I45ltUCLUTcpHm9xsI42ei3offb6S6N
         Wg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxfTFqLhtIlxiaNew08jchvdKl6M0DzpVExA2LcES3Q=;
        b=TZBUtEL/zpIL52YvUv0sUKVrY1hJ/XBjgO3t6a8/W+Hlc6oZ0BJS5A/iPDGEQWNPBW
         BggDIk6jyTPlQp2u4ZJKivXW2BxQFffifFqR3hE/HodmfFCBaN9PyQyAhJGjgKJ9d/d1
         rCWwRvsKye/S0pMZi4zhfNKnteIYTj0dobuImvIjqmTb9iWMEo9thUHtqSgOXygq1WAg
         MlNO/Fh4XDHb4nMQAu+5DGUcqq35xWAL2Aklpo2W/59cwX880vGvfO28/saoFxZgSa1d
         3H9rDSwU565hZv7SoywDQdnDARMv5S65Vtm3Q4dKLwI1Q0iJGik4cwVqY7w1+9g5ut6A
         zJPw==
X-Gm-Message-State: AOAM532zKxmS4FPamQ98cAH5A1TLq4icn9lXlM5YMLNZoD6NzsUlqBRo
        gxKaIiStrGd54cw1fa245JI=
X-Google-Smtp-Source: ABdhPJyPadyU+MWext58fydrQ6XhP1Vq82PQxy4nVNdMgVIyG/gocgK2V+YVT+ogPGIN1mCxaVeWzA==
X-Received: by 2002:a63:c14a:: with SMTP id p10mr1003167pgi.311.1627898345493;
        Mon, 02 Aug 2021 02:59:05 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n33sm12448088pgm.55.2021.08.02.02.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 02:59:05 -0700 (PDT)
Subject: [PATCH v3 8/9] docs: pdfdocs: Teach xeCJK about character classes of
 quotation marks
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <710d146e-dab1-4782-6332-8d10bf362178@gmail.com>
Date:   Mon, 2 Aug 2021 18:59:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quotation marks in "KR" and "JP" variants of Noto CJK fonts are half
width.
xeCJK assumes they are full width by default and does excessive kerning
around them in Korean and Japanese translations.

Give xeCJK proper hints by the \xeCJKDeclareCharClass command.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index c4813e51dbc9..846d57eba57c 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -425,6 +425,8 @@ latex_elements['preamble']  +=3D '''
 	\\newcommand{\\kerneldocEndTC}{\\endgroup}
 	\\newcommand{\\kerneldocBeginKR}{%
 	    \\begingroup%
+	    \\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}%
+	    \\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}%
 	    \\krmain%
 	    \\renewcommand{\\CJKrmdefault}{KRserif}%
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
@@ -434,6 +436,8 @@ latex_elements['preamble']  +=3D '''
 	\\newcommand{\\kerneldocEndKR}{\\endgroup}
 	\\newcommand{\\kerneldocBeginJP}{%
 	    \\begingroup%
+	    \\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}%
+	    \\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}%
 	    \\jpmain%
 	    \\renewcommand{\\CJKrmdefault}{JPserif}%
 	    \\renewcommand{\\CJKsfdefault}{JPsans}%
--=20
2.17.1




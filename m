Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9E3B2EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhFXMN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhFXMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:13:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33196C061766;
        Thu, 24 Jun 2021 05:11:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v12so2839893plo.10;
        Thu, 24 Jun 2021 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QnuZDfWJ9nUY4Zc0MaK45RKrAmdrTD6w8UxmpGOIRyI=;
        b=EAOZRQZ2OMS1GLn6X7klPVdCX3ep/RZioVkQJfbwT1VIIDNUQKthjOCFfDAU7Q5ztj
         CwgjbQLnpYw/Htbs0lq1cj96lxFVF+zCMiSEDp28/HUx6FUUilRchmj1ZIxeUcB4sbWy
         w0fvKZK2rKHXm9pcpuiQp017W20WiOvY9xcWgsEQ/299BZFNRDeLEhtLkZXHhXxsUDy0
         ha+reLbOVeeLS5R+d9ORQpPoV7PB7C6a1sFy+TGbfylahZkuXQESDYufj3IXwNLe7SW7
         ZFBUt04bwk5i13sK/gKO3w89EBWOwBZ+f18OS1IZDFkd32oeK5tYjsMoESaF6ErqVXwx
         WZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QnuZDfWJ9nUY4Zc0MaK45RKrAmdrTD6w8UxmpGOIRyI=;
        b=McKpL6PuG0Oe9vZFAF4c2m7w8jzPLyF6+TUZgA/di6/hUYM+RAHoHrzBhSOecxGh+z
         AMs2ev97+dcNXmNxX1vCSWYBO4YAx7BIIz3ac8fhWuudb4EpbsQ7oFVMaNa9jdqRNMbI
         4+8qZjgquccjunO5Gn/vU7iBFNfongolTVQgfB7QPkePO66aPjsxFVmTQcqBxd+ky5Ih
         cNpFlDJmDh/Blr8CWfIPnNV0rGGhHQX5ht403fwxOG2NejCKDxaaXC6pFVi/etLNyRzT
         hRq7U3dDM9ZbfbMbJBA01u9tIlqEVs1/DQjf1j5m02fQzf+rMA7d3a4OiCqpM3grXJtB
         H5PQ==
X-Gm-Message-State: AOAM532WQU4i4pFIzmBJ8W1SLIgXCkya7li/3VdD9f+cqnMi1RmYiLt4
        Wqy/MpZhNjDen5zGo0P5ZKI=
X-Google-Smtp-Source: ABdhPJxSwTVXBDsLsNKIlS/RY7XrUiKMt070hR/1H5U2W1ck5IbnHtKHjWvWO4TLEPvRaZk6AO0qqA==
X-Received: by 2002:a17:90a:6394:: with SMTP id f20mr14841367pjj.80.1624536691830;
        Thu, 24 Jun 2021 05:11:31 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w2sm2513240pjq.5.2021.06.24.05.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 05:11:31 -0700 (PDT)
Subject: [RFC PATCH 2/3] docs: pdfdocs: Add font settings for CJK ascii-art
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <c1dd4761-2c6e-9b99-f963-8d0d80142db3@gmail.com>
Date:   Thu, 24 Jun 2021 21:11:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is irrelevant to those who don't care translations docs.

Current font choice of "DejaVu Sans Mono" and "Noto Sans CJK SC" for
monospace fonts generates misaligned ascii-art figures in translations.

Using "Noto Sans Mono CJK SC" for both the monofont and CJKmonofont
choices is a better option.

As for Korean translation, there remain character width mismatches.

Hangul characters in "Noto Sans Mono CJK SC" are slightly narrower than
Chinese and Japanese characters, despite the "Mono" in the font name.

This results in mis-aligned ascii-art figures in Korean translation
of memory-barriers.txt.

Proper width Hangul characters are available in "Unifont", although with
degraded look of CJK characters due to Unifont's bitmap-font nature.

So "Unifont" is used only when it is found on the system.

Note 1: Unifont can be installed by:
    (Ubuntu) apt-get install ttf-unifont
    (Fedora) dnf install unifont-fonts

Note 2: Let us know if there is a better monospace font choice for Hangul.

Note 3: Sphinx itself is confused by tabs behind CJK characters. Korean
translation of memory-barriers.txt needs a couple of fixes to this
effect, of which a follow up change takes care.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 22f083bafaae..a95bd2123da1 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -363,12 +363,19 @@ latex_elements['preamble']  += '''
 	% This is needed for translations
 	\\usepackage{xeCJK}
 	\\setCJKmainfont{Noto Sans CJK SC}
+	\\setCJKsansfont{Noto Sans CJK SC}
+	\\setCJKmonofont{Noto Sans Mono CJK SC}
+	\\setmonofont{Noto Sans Mono CJK SC}
 	% Define custom macros to on/off CJK
 	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive}
 	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive}
 	% Inactivate CJK after tableofcontents (using etoolbox)
 	\\usepackage{etoolbox}
 	\\apptocmd{\\sphinxtableofcontents}{\\kerneldocCJKoff}{}{}
+	\\IfFontExistsTF{Unifont}{
+	    % For alinged Korean ascii-art
+	    \\setCJKmonofont{Unifont}
+	}{}
     }{ % No CJK font
 	% Custom macros to on/off CJK (Dummy)
 	\\newcommand{\\kerneldocCJKon}{}
-- 
2.17.1



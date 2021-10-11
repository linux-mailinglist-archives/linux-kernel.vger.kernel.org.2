Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2434284FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 04:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhJKCHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 22:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhJKCHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 22:07:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F73C061570;
        Sun, 10 Oct 2021 19:05:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso9825108pjb.1;
        Sun, 10 Oct 2021 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=63V6FE+fQW+SKi4KjZOqiA/PPlGq7C8uAp1sNW6G/lE=;
        b=YK0ry9+6jUEWi3XytvEl7n3HWuSftzNe/vVUS5EyJIaSu+QXECvi5h+uUQalpBR5ky
         sJjrt2tsg/C2zXy5LgU1S9tJn4Os8YZS8DaytV3PuJJfjYegehLt3/zVa0NTsF3e4pJW
         GaT+cyiNi6T8cOry9xmSp/xt4vpPb69A2xs65cue6c2o33rdfv8YvfTdOFNfKCeaRRFt
         p02tkZ86+AXqA4Zc/+iYN0q6PX4isfaEAauq4srjIo7vv+ebGvLpSzD6ZlVM0+879L+m
         W4DgqnHqxskmuAHLPqhqxTAr930+Vs5hxf/6lmNK0sZ99LrX7SvmXixVdFX38AFU0psh
         JSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=63V6FE+fQW+SKi4KjZOqiA/PPlGq7C8uAp1sNW6G/lE=;
        b=G8/3w91mkcGli+/19zGanT/ltTzIOVtbGju2rjQwZwNQ9FhGJZtC3Q6csohksjj+qh
         2PaCwhQQj6oytmB2Z/gcYLNSGnae7/2bSEgF73cJhvBGUk4fY7wxvP8e7tsgsno/3j7e
         BQHgLZ4yLUm6RdbV5bhwSaL9qguMsTYacn2XJCOk3WrcBs+fik1EWf72vgFsrAMT+Rh0
         nyo/yh7LWAFyR+PFqYG3zYBe084skmSaSoPlDYd/IAGVYGSTVV0KIst8ypoShUoznUnp
         qbWOElx6Boh0if5mtl8pc6h2V9O77LrbX1D0f8bO497Spwj9ygp7xAMiz+ysqW5D+KBe
         u+Pw==
X-Gm-Message-State: AOAM533iQiGApjuzvJMTvSgLJ5CagADU+lsbdcFWIRkE1/6WjpdyA4Rk
        HJ/PxHXR0PvD6pZyUOFRZ1E0EwO2GKE=
X-Google-Smtp-Source: ABdhPJzX5fCZjS7AyWKdVTEXgbxHYj08Sl8KmKQcKkvtOxnuKpJD7hbLgsKviAILL8aFkCdQHW5O2A==
X-Received: by 2002:a17:902:780f:b0:13a:3a88:f4cb with SMTP id p15-20020a170902780f00b0013a3a88f4cbmr22093431pll.68.1633917907564;
        Sun, 10 Oct 2021 19:05:07 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i1sm6205802pgc.94.2021.10.10.19.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 19:05:07 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: pdfdocs: Adjust \headheight for fancyhdr
Message-ID: <c5a5577e-5de8-9cd4-9253-956ccc748417@gmail.com>
Date:   Mon, 11 Oct 2021 11:05:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fancyhdr prior to v4.0 outputs a message per document as follows:

    Package Fancyhdr Warning: \headheight is too small (12.0pt):
    Make it at least 13.59999pt.
    We now make it that large for the rest of the document.
    This may cause the page layout to be inconsistent, however.

Fancyhdr v4.0 complains (once a page!) as follows:

    Package fancyhdr Warning: \headheight is too small (12.0pt):
    (fancyhdr)    Make it at least 13.59999pt, for example:
    (fancyhdr)    \setlength{\headheight}{13.59999pt}.
    (fancyhdr)    You might also make \topmargin smaller to compensate:

    (fancyhdr)    \addtolength{\topmargin}{-1.59999pt}.

Related item in fancyhdr v4.0 announcement on 2021-01-04 [1]:

    Backward incompatible changes:
      - Eliminate adjustments of \headheight or \footskip, when the
        header or footer is too high.

[1]: https://www.ctan.org/ctan-ann/id/mailman.2685.1609863692.2532.ctan-ann@ctan.org

Silence the warnings by adding a couple of \addtolength commands in
the preamble.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi,

This update doesn't have much visual effects in the final PDFs
(adjustment of only 1.6pt), but getting rid of harmless warnings
would help spot potential important ones.

Tested against Sphinx versions 2.4.4 and 4.2.0, with Tex Live
versions 2017/debian (Ubuntu 18.04), 2019/debian (Ubuntu 20.04),
and vanilla 2021 (as of 2021-10-08).

        Thanks, Akira
--
 Documentation/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 948a97d6387d..17f7cee56987 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -353,6 +353,9 @@ latex_elements = {
         \\setsansfont{DejaVu Sans}
         \\setromanfont{DejaVu Serif}
         \\setmonofont{DejaVu Sans Mono}
+        % Adjust \\headheight for fancyhdr
+        \\addtolength{\\headheight}{1.6pt}
+        \\addtolength{\\topmargin}{-1.6pt}
      ''',
 }
 

base-commit: 7275423c177e5dcf53e350ab9db38f99946b8ec5
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC4D4586E1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 23:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhKUXAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 18:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhKUXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 18:00:15 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45157C061714
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:57:10 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so26119323otg.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9XpcC2OzJKUPIULTfHPzivkbHxJbmpO+PtuVvED5p2I=;
        b=mVoyODWPGJCR+2Aba02Adr7LwF8b5MfaDHuieArmPUpfYS778GnhgKQAbvpVFoNWTM
         BFf/+vNPQfOSWaZiNcYF7XwGuGJgnYy6RnCa/9sljFofJACgWpichxq9pTbJUyjkgmKW
         ulkzWJm5Qck6BKKVyVHxNZzis2Lz1BPBL2eTPruicv/xWAwkV4Q9vwPwgS093JrilN4o
         Nv5IslpCAjs9AKKA2NMiCsNAUzwtx+5Z757VFEvIIp8uvjprc1boLADUzpC+O0yexslY
         RnEW7OJwhiOR09CkfYGoKfkNTbbJDjQW8g4aojgo64VOhyI/pFySTWwaEiZ3RP6mJI2j
         ShZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9XpcC2OzJKUPIULTfHPzivkbHxJbmpO+PtuVvED5p2I=;
        b=4r86IE4g+FFdpv2gBYbc69HI74EH7mLwRHf81dLbh9bmsivQTlgGmCjquhDERufeyw
         WamRpr9HcArAn8E4JE52BfLJELZBN0Ltx6NiMumleauNWXB6VySbxl1WO6P2f4YlpOyE
         Gd4E8LbBTRBlwIfoeatHDcIWpEczzy935eGbqlqHxC9hR7CX+GLjVUq0ZvB7IZmInQU4
         V4yJoIP/RF013+PV3z75qTXvaBpCyLerwrDNnIfWx8dSA290zauglV2gAJ1kK5BmDKIz
         Izch27IIVO+DhioYU6MM0QWwMvxnHtA45Dvfc4yYFXPRlRhMGy8Ucu6Kbz2uKht4cKZB
         s6yA==
X-Gm-Message-State: AOAM532CY1NkvR+uQ8z+pauOgFd7AVtAwEKfmOyNyYsWQJZH15b0mAvi
        zslwG/ulPw4gsifi0tB+UdlUVSG5q/K81r1Sw1lCJDdKH3Q=
X-Google-Smtp-Source: ABdhPJxzNFh6C9N+oywTSQc3Tu6q4zZFkC2s7yr/nmKU6Lmxipg1uw0WFkxVFR5of0PSyTxufTbf5CuuXzrFU4AEA5w=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr21295623otg.179.1637535429674;
 Sun, 21 Nov 2021 14:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20211110165720.30242-1-zajec5@gmail.com>
In-Reply-To: <20211110165720.30242-1-zajec5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 21 Nov 2021 23:56:58 +0100
Message-ID: <CACRpkdbQVJTnVH8LBKAY3eCXvZLRnXXEMdgNtGwWVb0Zhk94sA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: convert controller description
 to the json-schema
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 5:57 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> This helps validating DTS and writing YAML files.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

This looks good to my eyes but I definitely need Rob to look at this before
merging!

Yours,
Linus Walleij

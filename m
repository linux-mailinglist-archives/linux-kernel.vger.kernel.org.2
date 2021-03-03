Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459FD32BDB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384916AbhCCQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350159AbhCCLvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:51:21 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0CEC0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:45:14 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id d5so20942541iln.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 02:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc:content-transfer-encoding;
        bh=TR7NNEuIpBsy8PLWrtIcE08WBEGVjafctESBuPAPQpg=;
        b=CrmVVfAdqxrZrTbppssaU+QLKqwGipTp+EDmOkQV3qpq2q7OCXniliznafrPOwKBWJ
         fO+MtZdOJwuERbSMtr/Bjxx4A1YXpbHnYqFUWvUnq5QVfIoPg/KsU15tVZLXJHWyGaLc
         J0r2z2kNMr4T3Ky+dSQhCKvA43SRJ/blf6FDLlUTcu3w0ap/d1CGerQU/9ZdGUrgyUcS
         86dyLfizxSPc6Y+CFJA9gMzUlIw3bKIbJksrak0C130JbM8tUp4ImeZEMcLKDMDd9Sqd
         uNibN7PfQddc86kvVQ5aTa35FXYYOQcfT5UU336n4MeCQAExpsxl0z0mU3TyAC3HCKVn
         T/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc:content-transfer-encoding;
        bh=TR7NNEuIpBsy8PLWrtIcE08WBEGVjafctESBuPAPQpg=;
        b=JM3fEdfusmGlamEZm+XzNAIgqpIpIOAsJaT5pRm4r/xcru3HYejKpiuzaJIkeNZNL/
         z+r5MpgUpV3XI8SMstjqTi5QAEtFSMCDN54jepFWjcKVv51E/Yz/6rOeHlvQePYAMrm+
         xG0mjbRk3dRjLFqX0X1y41Np9a4S8wVu83RDp3gQkQRkf1snE2/h5SK5uvHX44gdAjZP
         E0GvPEPxV40DgDfWkI/QGLC1gdljxa4OWRNepiDpOoq4/r23mkEuJEyo1lh58Yw/LrnA
         NUMfYwelZ/RR4HuSyQ9M0b3dIoFtNOJvxTtnxoMGWTfdWlmHanRJYk1cYEIVlef86rtS
         yGAQ==
X-Gm-Message-State: AOAM531HhodYzmqbc7V+0PHkRd2B3ttjxKr1Hiu0jYOUV2z0r0y0avMl
        MPoGJsJ+mdTQgM3wAKg8FvAGXBGUz/yGWzO+n9w=
X-Received: by 2002:a92:6511:: with SMTP id z17mt21361809ilb.232.1614768314006;
 Wed, 03 Mar 2021 02:45:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:84ec:0:0:0:0:0 with HTTP; Wed, 3 Mar 2021 02:45:13 -0800 (PST)
Reply-To: atmcarddelivery001@post.com
In-Reply-To: <CAJDWG3sxZbrFKUCjEcUcwAaCR3ydTmZjmXvODHdj4O6+OXMX7A@mail.gmail.com>
References: <CAJDWG3si1z1aSnBm0SusXhzU1+gzPkQYaG2_2sa58H48mc0Rcw@mail.gmail.com>
 <CAJDWG3s+9k8u4uUBQfSp38mUXmx4b+Ow473WL4t3d6t+vBvr2A@mail.gmail.com>
 <CAJDWG3uVH_5pFReCrkFp9UzmJorxNS7j7jWChsYbXYMkLnYBSQ@mail.gmail.com>
 <CAJDWG3v5ChYcmcXLd7tb4dE-3U65U9p8vZwHdF8jRkv-=6a9cQ@mail.gmail.com>
 <CAJDWG3vuxf04ge0YbrquQayJhZada39ymZDVHU2gCBhB_J7f5g@mail.gmail.com> <CAJDWG3sxZbrFKUCjEcUcwAaCR3ydTmZjmXvODHdj4O6+OXMX7A@mail.gmail.com>
From:   eccobank uniontgl <ecobankuniontglomeoffice@gmail.com>
Date:   Wed, 3 Mar 2021 10:45:13 +0000
Message-ID: <CAJDWG3uevZ3nOYChFTwc5TtaGwrj=EVbvc2wOW9p55APbV5m2g@mail.gmail.com>
Subject: HELLO
Cc:     chukwuemedani <chukwuemedani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7KO87J2YLA0K6reA7ZWY7J2YIO2OgOuTnOyXkCDrjIDtlZwg7LWc7KKFIO2ajOydmCDtm4Qg7Juo
7Iqk7YS0IOycoOuLiOyWuCDrtoDshJzrpbwg7Ya17ZW0IOq3gO2VmOydmCDtjoDrk5wg7IiY7ZGc
ICjrr7jtmZQgMzUwIOunjCDri6zrn6wp66W8IOyeheq4iO2WiOyKteuLiOuLpC4g7J2066mU7J28
DQooYXRtY2FyZGRlbGl2ZXJ5MDAxQHBvc3QuY29tKeydhCDthrXtlbQg7Juo7Iqk7YS0IOycoOuL
iOyWuCDsnbTsgqwg7J24IFBoaWxpcCBVZG9tIEp1ZGUg67CV7IKs7JeQ6rKMDQrsl7Drnb3tlZjs
i5zrqbTrkKnri4jri6QuICkuIOq3uOuKlCDri7nsi6DsnbQg66ek7J28IOq4sOq4iOydhOuwm+yd
hCDrsKnrspXsl5Ag64yA7ZWcIOyngOyLnOulvCDspIQg6rKD7J6F64uI64ukLiDri6TsnYzqs7wg
6rCZ7J2AIOyemOuqu+uQnCDsoITshqHsnYQg7ZS87ZWY6riwIOychO2VtA0K6re47JeQ6rKMIOyg
hOyytCDsoJXrs7Trpbwg67O064K064qUIOqyg+ydhCDsnorsp4Ag66eI7Iut7Iuc7JikLg0K7IiY
7Leo7J24IOydtOumhCBfX19fX19fX19fX19fX18g7KO87IaMIDogX19fX19fX19fX19fX19fXyDq
ta3qsIAgOiBfX19fX19fX19fX19fIOyghO2ZlCDrsojtmLgNCjogX19fX19fX19fX19fXw0K7ZWY
7KeA66eMIE1yLk5JQ0hPTEEgQUdVQUdV6rCAIOyYpOuKmCDqt4DtlZjsnZgg7J2066aE7Jy866Gc
IFdlc3Rlcm4gVW5pb27snYQg7Ya17ZW0ICQgNTAwMOulvCDrs7Trg4jsirXri4jri6QuDQrrlLDr
nbzshJzsnbQg7J2066mU7J287J2E67Cb64qUIOymieyLnCBEci5QaGlsaXAgVWRvbSBKdWRl7JeQ
6rKMIOyXsOudve2VmOyXrCBNdGNuLCDrsJzsi6DsnpAg7J2066aEIOuwjyDsp4jrrLggLyDri7Xr
s4DsnYQg7KCc6rO17ZWY7JesDQokIDUwMDDrpbwg7ISg7YOd7ZWY64+E66Gd7ZWY7Iut7Iuc7Jik
LiDrqqjrk6Ag7J6Q6riI7J2EIOuwm+ycvOuptCDsponsi5wg7JWM66Ck7KO87Iut7Iuc7JikLg0K
6rCQ7IKs7ZWp64uI64ukLiBXRVNURVJOIFVOSU9OIEFHRU5UZg0K

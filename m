Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA74542110E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhJDONx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhJDONw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:13:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBBEC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 07:12:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z20so13939949edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/uBO/PTl4ZkWnhTh7LICzUGbZ+4dMRmzs+4ecs0mqcA=;
        b=LDptbEVP5pFmLEdU34ZsM22XxcRi9XQIp+8hF3Lo7nIEQZEihrVdehyMRi7lhK77/M
         ecf0kvjrQ59UvMnfwSBbdqhB5AgwnPYicQ7YvMuJNfjmgVacLoipGwkjnpYB3TkLttHX
         SYZibZT3MdDvBspanMqTDTC6Jfu1R1ZvZjvAs6O1Andpe+qmVJszK2YKCU5XH76ZYa9b
         NSA6suL9tzqbLOQyaDVlpDo7oxt+spmLGfkRPRYP1iw6G4Xl1yMjqNoJe6sf5/dXviJF
         6scN5l05mgT2FJC1xsI2hbv1P3A+QMckdfOxrz2Vb/50850O3jb+Cv4XeHT60LSoAv/h
         5Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/uBO/PTl4ZkWnhTh7LICzUGbZ+4dMRmzs+4ecs0mqcA=;
        b=ZfbEZ+Fc8TPDohc6LESTexvtGyc9cy4EZ2k8ym9S7/Z6M4kWZJ+u/uiTS/7EZdVHCx
         DlpqVycv0dQC+h78Q1Qd08DqBGh8PzTdRJ7A/hkuplbaTuPe2VPAijRdK2J+LI4pxwyG
         H5gZj2eUbFBxDsmqlmcg+x6F1JJS2PFmzDxx7xq3msJdQqXyPMjkBVrkmeeUp6CkCF+q
         IxA0x10gVA1VfVLDT+VfTVb+0VE97cRiqFbF0f57Rjt8nzIsycJ6Ai569EtPt6snG+k1
         XY31B7tcspMsqXruU+xYV+xSjwUVc5HCKGQXKyxAVVKp2Eb9F3EUQo5O182VZi7xlnl8
         N32g==
X-Gm-Message-State: AOAM532eD8UmeCZ87d6aYbBZMcgrG2S9DmIuK7q5ti3VGNRWUE1HMoXu
        0W8zT3gnyyPGj04aNeqvWltsy2L0VPEMO2kNZC2R2Q==
X-Google-Smtp-Source: ABdhPJwzRJgYW9Wzyb7NdLDHgOTWL/HLhrOplEvZqqHgDK2YTEhWBMJt3Cu0L+OFXfj/dIGcgcPBXEPsgBwq0jLOduY=
X-Received: by 2002:a17:907:3e03:: with SMTP id hp3mr17158492ejc.183.1633356673544;
 Mon, 04 Oct 2021 07:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211002231723.29019-1-ammar.faizi@students.amikom.ac.id> <20211004090524.GS2048@kadam>
In-Reply-To: <20211004090524.GS2048@kadam>
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Date:   Mon, 4 Oct 2021 21:11:00 +0700
Message-ID: <CAGzmLMVMmzcP3ih33QhxOBbiqBZRgfiz6ke5K6UMcSeope8Jag@mail.gmail.com>
Subject: Re: [PATCH] media: atomisp: fix `-Werror=return-type`
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bedirhan KURT <windowz414@gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 4:06 PM Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>
> On Sun, Oct 03, 2021 at 06:17:23AM +0700, Ammar Faizi wrote:
> > Bedirhan reported build error:
> > ```
> >   drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_syst=
em.c: In function =E2=80=98input_system_configure_channel_sensor=E2=80=99:
> >   drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_syst=
em.c:1649:1: error: control reaches end of non-void function [-Werror=3Dret=
urn-type]
> >    1649 | }
> >         | ^
> >   cc1: some warnings being treated as errors
> >   make[4]: *** [scripts/Makefile.build:277: drivers/staging/media/atomi=
sp/pci/hive_isp_css_common/host/input_system.o] Error 1
> >   make[3]: *** [scripts/Makefile.build:540: drivers/staging/media/atomi=
sp] Error 2
> >   make[2]: *** [scripts/Makefile.build:540: drivers/staging/media] Erro=
r 2
> >   make[1]: *** [scripts/Makefile.build:540: drivers/staging] Error 2
> >   make: *** [Makefile:1868: drivers] Error 2
> > ```
> >
> > Commit 264f590899146baa19e0ab5689e55fadbc292333 ("media: atomisp:
> > remove useless returns") incorrectly removed a required return results
> > in the above build error. Reinstate it.
> >
> > Cc: Pavel Skripkin <paskripkin@gmail.com>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Cc: linux-media@vger.kernel.org
> > Cc: linux-staging@lists.linux.dev
> > Cc: linux-kernel@vger.kernel.org
> > Reported-by: Bedirhan KURT <windowz414@gnuweeb.org>
> > Fixes: 264f590899146baa19e0ab5689e55fadbc292333 ("media: atomisp: remov=
e useless returns")
> > Signed-off-by: Ammar Faizi <ammar.faizi@students.amikom.ac.id>
>
> What's going on with this?  It's like the seventh time people have sent
> a fix for it?  Why are you not using against a current tree?
>
> regards,
> dan carpenter
>

Sorry for the duplicate. It broke my build. I am using Linus' tree
5.15-rc4, the error still lives here. My mistake, I didn't check the
linux-next tree before sending this fix.

--=20
Ammar Faizi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE54357C7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhDHGUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhDHGUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:20:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7D6C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 23:20:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f29so657061pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=TsbSyPqcXIpypJS2UxalQLeYcuAIVrM3yNjiNzBQiuw=;
        b=MAdstSYYrcSMuaaI8CP2BXExnhOsX2vyV3ze4dGRwDqc8dqULs+9Y+RCyG3aq7ftT7
         XUi+TNuqaAHnyZb69kEz+UD9KKQWbQYZaCTelmss7wCI/h4tPfi5rGRNYE7OQ+ZCErdM
         9/fUFLVRxgPGFoFlk2E8XysGJqCeZYgfhG/Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=TsbSyPqcXIpypJS2UxalQLeYcuAIVrM3yNjiNzBQiuw=;
        b=ns1Iy7hpHivgw/XHQf03qHQDQZkeXSgJ2ltImFLCdDJGbk/VZZgURUACRChKMqvOha
         vACzHym1iLoe9hYP3HKQVlXiwbdCUwlFePMKVlR1yzzEi2wZ2A04jW6wuUulhW87yLVi
         4yk4Q+x5Le4BHJrDG74+J1RkHTC82xV5AivKbTvtB9fP8MUB24KLJyqc07nHGYT7Jh1M
         iUPpaoSK1NHDFsJZAShEdCCdN0KjHTwgFNHyrJ9tNBT3TIJGA9xiijifHQeCU1U3+zrL
         OjdvB6S3yyHQNAFBQAYsKtydJStap1Vwe5Cp+Ih50uRL1OKS6xXdnwRXhTarLDX+32I3
         FyGA==
X-Gm-Message-State: AOAM531HL7f0EJKJj1FIPTdwugLGGu82i6mIucdVBzvW59YkriEw3pDX
        /gt4URmPc/Gmyom9sn7QFlodrQ==
X-Google-Smtp-Source: ABdhPJx6CbQN+VMSkYRLakjVeUzjMlix7hdETPfRbttr/GYgRgc4jzw8NFfcq3tT6l5Vm9frZ06tnw==
X-Received: by 2002:a63:f056:: with SMTP id s22mr6642577pgj.369.1617862834841;
        Wed, 07 Apr 2021 23:20:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e193:83c5:6e95:43de])
        by smtp.gmail.com with ESMTPSA id 184sm6658514pfx.156.2021.04.07.23.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 23:20:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YG27p1AhiOKJOm+y@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org> <20210331030520.3816265-4-swboyd@chromium.org> <YG27p1AhiOKJOm+y@alley>
Subject: Re: [PATCH v3 03/12] dump_stack: Add vmlinux build ID to stack traces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Date:   Wed, 07 Apr 2021 23:20:32 -0700
Message-ID: <161786283299.3790633.9395579294249054249@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-04-07 07:03:19)
> # readelf -Wn vmlinux-5.12.0-rc6-default+=20
>=20
> Displaying notes found in: .notes
>   Owner                 Data size       Description
>   Xen                  0x00000006       Unknown note type: (0x00000006)  =
  description data: 6c 69 6e 75 78 00=20
>   Xen                  0x00000004       Unknown note type: (0x00000007)  =
  description data: 32 2e 36 00=20
>   Xen                  0x00000008       Unknown note type: (0x00000005)  =
  description data: 78 65 6e 2d 33 2e 30 00=20
>   Xen                  0x00000008       Unknown note type: (0x00000003)  =
  description data: 00 00 00 ffffff80 ffffffff ffffffff ffffffff ffffffff=20
>=20

Thanks for the readelf output. That was most helpful to see what's going
on. The buildid code isn't prepared for this it seems. We'll need to
check the note data to see if it starts with "GNU\0" and if it does then
we use it as the buildid. I'm not sure what this Xen note is that has a
type of 3 but I think that's OK, it won't have "GNU" in there so we
should ignore it. Does this patch work?

----8<----
diff --git a/lib/buildid.c b/lib/buildid.c
index 483abf71eeec..f281dbe6fb83 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -25,6 +25,7 @@ static int parse_build_id_buf(unsigned char *build_id,
=20
 		if (nhdr->n_type =3D=3D BUILD_ID &&
 		    nhdr->n_namesz =3D=3D sizeof("GNU") &&
+		    !strcmp((char *)(nhdr + 1), "GNU") &&
 		    nhdr->n_descsz > 0 &&
 		    nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
 			memcpy(build_id,

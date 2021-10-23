Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6163C438469
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhJWRHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhJWRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 13:07:48 -0400
X-Greylist: delayed 186 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Oct 2021 10:05:29 PDT
Received: from smtp.outflux.net (mta.outflux.net [IPv6:2001:19d0:2:6:c0de:0:736d:7471])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46120C061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 10:05:29 -0700 (PDT)
Received: from auth (localhost [127.0.0.1]) (authenticated bits=0)
        by vinyl.outflux.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id 19NH1G5h005724
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 23 Oct 2021 10:01:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=outflux.net;
        s=2016010; t=1635008477;
        bh=HJ2FncMHXdeq3iIGAPXeJDeLV4Lnj+hYTF/49t+Z+9c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fNh/nv9ZPjanHdgdCokXr2RwOvIe9RGMJtg8FbshdSd8ihtnQGVCachF1Bu/cbwoj
         CoJJHLfOZmhwIHAhM42fzFlgzMkA8ykpmftAXAPzUNM76knGW3oQlu1ETgFKvoV481
         PfA/62brKmME66TtoITSArAZ3v8DrK4swlWsj5cs=
Date:   Sat, 23 Oct 2021 10:01:16 -0700
From:   Kees Cook <kees@outflux.net>
To:     Julia Lawall <julia.lawall@inria.fr>, Joe Perches <joe@perches.com>
CC:     cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: [cocci] update Coccinelle entry
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.22.394.2110231758550.2967@hadrien>
References: <alpine.DEB.2.22.394.2110231758550.2967@hadrien>
Message-ID: <6A7FEC25-CBC1-434D-BD81-1FDB81DD9B45@outflux.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: [127.0.0.1]
Envelope-To: linux-kernel@vger.kernel.org
Envelope-To: cocci@inria.fr
Envelope-To: joe@perches.com
Envelope-To: julia.lawall@inria.fr
X-Scanned-By: MIMEDefang 2.83
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 23, 2021 9:01:18 AM PDT, Julia Lawall <julia=2Elawall@inria=2Ef=
r> wrote:
>Update mailing list and website=2E  Drop Michal Marek as a maintainer, wh=
o
>has not participated in a long time=2E
>
>Signed-off-by: Julia Lawall <Julia=2ELawall@inria=2Efr>
>
>---
>
>For information=2E  This will be in my tree=2E
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 7d46f03e5037=2E=2E8746149b6623 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -4594,10 +4594,9 @@ COCCINELLE/Semantic Patches (SmPL)
> M:	Julia Lawall <Julia=2ELawall@inria=2Efr>
> M:	Gilles Muller <Gilles=2EMuller@inria=2Efr>
> M:	Nicolas Palix <nicolas=2Epalix@imag=2Efr>
>-M:	Michal Marek <michal=2Elkml@markovi=2Enet>
>-L:	cocci@systeme=2Elip6=2Efr (moderated for non-subscribers)
>+L:	cocci@inria=2Efr (moderated for non-subscribers)
> S:	Supported
>-W:	http://coccinelle=2Elip6=2Efr/
>+W:	https://coccinelle=2Egitlabpages=2Einria=2Efr/website/
> T:	git git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/mmarek/kbuild=
=2Egit misc

Perhaps drop this tree and add yours, too?

> F:	Documentation/dev-tools/coccinelle=2Erst
> F:	scripts/coccicheck




--=20
Kees Cook

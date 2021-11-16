Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E38453BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhKPVrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhKPVro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:47:44 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB83C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:44:46 -0800 (PST)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 1FAF1C9F0E7;
        Tue, 16 Nov 2021 22:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1637099083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vNtgQwhvRJ3btZOLMF0aZgSB/nWKd30Dkl7bsUQ2yBM=;
        b=Y7OBf57RxXxFHs4hTKzS8B4RuRnFqiRE9eyghwYqGzy1HOmqu11cYu6LcxIbQmeKmVe4Am
        XieVm3k7d1Jrhj2asfCLPTLrgxJqL9/7jpAISL101/SmPHYoFTLDGMXpD/LnMjTjtLTtRZ
        MK8b+swZzDbUCWMyV6JxqXXYTOCecc4=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: ksmbd: Unsupported addition info
Date:   Tue, 16 Nov 2021 22:44:41 +0100
Message-ID: <5831447.lOV4Wx5bFT@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Namjae et al.

With the latest ksmbd from the next branch I have an issue with wife's Wind=
ows=20
10 laptop while copying/removing files from the network share. On her clien=
t it=20
looks like copy operation (server -> laptop) reaches 99% and then stalls, a=
nd=20
on the server side there's this in the kernel log:

```
ksmbd: Unsupported addition info: 0xf)
ksmbd: Unsupported addition info: 0x20)
```

repeated multiple times. I must note that in fact the file gets copied to h=
er=20
laptop, but Windows copy dialog just hangs.

Any idea what it could be and how to avoid it? This also happened before (I=
'm=20
a pretty early ksmbd adopter), but I'm reporting it just now because I na=
=EFvely=20
hoped it would be fixed automagically :). This never happened to me with=20
userspace Samba though.

This is my smb.conf:

```
[global]
workgroup =3D KANAPKA
server string =3D ksmbd server %v
netbios name =3D defiant
valid users =3D __guest

[Shared]
valid users =3D __guest
path =3D /mnt/shared
force user =3D _shared
force group =3D _shared
browsable =3D no
writeable =3D yes
veto files =3D /lost+found/
```

Appreciate your time and looking forward to your response.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)



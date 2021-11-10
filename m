Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73844BDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhKJJhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:37:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhKJJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636536882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxMV4iFPRrUOhxosXQa0hRM/ty1+W5Q/Tq2s1HhpRhc=;
        b=WTbbQPkqcJPbXxGhtij0L/A1fV/imBCuYc8UHUOjNufc4z39KcXpQ6LDLpO3U5qC/+X5oB
        BCU6plJTXWQSQlnSanXFZ+yPsnVqaPxOV/jK3vvMq8IKprxI8pu9DVwpF9bW0exl3jo1RZ
        Sr6QC/1xuQn7H4FqlMmhZ9nZ19MqH1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-6K9XdtpxPVKtVRrmf2mo3w-1; Wed, 10 Nov 2021 04:34:39 -0500
X-MC-Unique: 6K9XdtpxPVKtVRrmf2mo3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E2419253C2;
        Wed, 10 Nov 2021 09:34:37 +0000 (UTC)
Received: from localhost (unknown [10.39.193.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA6960843;
        Wed, 10 Nov 2021 09:34:33 +0000 (UTC)
Date:   Wed, 10 Nov 2021 09:34:32 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Andra Paraschiv <andraprs@amazon.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <YYuSKEqj3UMLNAfw@stefanha-x1.localdomain>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6kCy5STPFCJ1ef5p"
Content-Disposition: inline
In-Reply-To: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6kCy5STPFCJ1ef5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 07:12:36AM +0000, Wang, Wei W wrote:
> We plan to add a new vsock transport based on hypercall (e.g. vmcall on I=
ntel CPUs).
> It transports AF_VSOCK packets between the guest and host, which is simil=
ar to
> virtio-vsock, vmci-vsock and hyperv-vsock.
>=20
> Compared to the above listed vsock transports which are designed for high=
 performance,
> the main advantages of hypercall-vsock are:
>=20
> 1)       It is VMM agnostic. For example, one guest working on hypercall-=
vsock can run on
>=20
> either KVM, Hyperv, or VMware.
>=20
> 2)       It is simpler. It doesn't rely on any complex bus enumeration
>=20
> (e.g. virtio-pci based vsock device may need the whole implementation of =
PCI).
>=20
> An example usage is the communication between MigTD and host (Page 8 at
> https://static.sched.com/hosted_files/kvmforum2021/ef/TDX%20Live%20Migrat=
ion_Wei%20Wang.pdf).
> MigTD communicates to host to assist the migration of the target (user) T=
D.
> MigTD is part of the TCB, so its implementation is expected to be as simp=
le as possible
> (e.g. bare mental implementation without OS, no PCI driver support).

AF_VSOCK is designed to allow multiple transports, so why not. There is
a cost to developing and maintaining a vsock transport though.

I think Amazon Nitro enclaves use virtio-vsock and I've CCed Andra in
case she has thoughts on the pros/cons and how to minimize the trusted
computing base.

If simplicity is the top priority then VIRTIO's MMIO transport without
indirect descriptors and using the packed virtqueue layout reduces the
size of the implementation:
https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x=
1-1440002

Stefan

--6kCy5STPFCJ1ef5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGLkigACgkQnKSrs4Gr
c8iPyAf8COmUtjvTHk5gX6zSZeAiKXrfyy3bnkP9NrNwxXTHGg7f6dECVUz9Gg73
+YqbL+Li11VWyTGCltsAWVkcVmmeuW+vdAUhuxBRRoWw8VCoLKbMUif/rJV48Ms8
KQN5ZEoGSMVFpNj6P7V6qlPMC8MRGLfeqouNZpbL5z/gTfef+vQvKGjR7NF3CegG
CtVR2NXN+sE+bOPHB9VY11YzBlSLNcuivqb4k288LkTqemVcMQloN2w6bYkzaUP5
IwdGx3PP13yFkDDKYv4PnJ3VJPDYVrL0Y1mxNAlFhtQ2bBnk8l3DapR/Z906kVYb
bG7G+2Sb/uf0m34bQgrAokLNk8nWGA==
=bN/Z
-----END PGP SIGNATURE-----

--6kCy5STPFCJ1ef5p--


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5634D4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhC2QYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhC2QXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617035015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XI84iZTRDWoAG38cDh4IhJ7kgX/ztNT961J0uIm+CnQ=;
        b=b6HPRJkLe+4w7yD994pZqcwM7XmMv2gU79C/jbQ7v+haK1bbIOrJ2zsoEmv20kLFLUJeME
        SqlMm8x1dgqgDy6f+8G/P6RusGGwXmss19JRNyR3JjbWlbWU30IY/qCBPukzLyPs3kJiuK
        fkqRVeoVjJ6Xwd+gciaAwaFOJ0AdOLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-XhYDoezHNVaajJPJ79R3Kg-1; Mon, 29 Mar 2021 12:23:33 -0400
X-MC-Unique: XhYDoezHNVaajJPJ79R3Kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DAC7100F76C;
        Mon, 29 Mar 2021 16:23:32 +0000 (UTC)
Received: from localhost (ovpn-114-227.ams2.redhat.com [10.36.114.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D0F36F968;
        Mon, 29 Mar 2021 16:23:21 +0000 (UTC)
Date:   Mon, 29 Mar 2021 17:23:20 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Sochin Jiang <jiangxiaoqing.sochin@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        lizefan.x@bytedance.com, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] virtio_blk: make virtio blks as non-rotational devices
Message-ID: <YGH++CMejgUlvBy1@stefanha-x1.localdomain>
References: <20210326033914.65483-1-jiangxiaoqing.sochin@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ngZFjV0XBYrCqjZn"
Content-Disposition: inline
In-Reply-To: <20210326033914.65483-1-jiangxiaoqing.sochin@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ngZFjV0XBYrCqjZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 26, 2021 at 11:39:13AM +0800, Sochin Jiang wrote:
> This confuses some users seeing one rotational block device
> in the guest(/sys/block/vdx/queue/rotational), let's make
> virtio blks as virtual block devices, just like xen blks,
>  and as we known, QUEUE_FLAG_VIRT is defined as QUEUE_FLAG_NONROT
> actually. See also rbd and nbd block devices.
>=20
> Signed-off-by: Sochin Jiang <jiangxiaoqing.sochin@bytedance.com>
> ---
>  drivers/block/virtio_blk.c | 1 +
>  1 file changed, 1 insertion(+)

I would like to make this change because it seems consistent and often
the disk really is non-rotational. However, a justification and
performance results are needed especially since this has been reverted
previously. Please see commit f8b12e513b953aebf30f8ff7d2de9be7e024dbbe
("virtio_blk: revert QUEUE_FLAG_VIRT addition").

That was in 2009, so maybe things have changed now. Please explain what
has changed in the commit description.

This flag can affect performance. Please include performance data.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..31a978a4dab5 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -822,6 +822,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		max_size =3D min(max_size, v);
>=20
>  	blk_queue_max_segment_size(q, max_size);
> +	blk_queue_flag_set(QUEUE_FLAG_VIRT, q);
>=20
>  	/* Host can optionally specify the block size of the device */
>  	err =3D virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> --
> 2.11.0
>=20

--ngZFjV0XBYrCqjZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBh/vgACgkQnKSrs4Gr
c8jUmgf+LTGpf2nf6Y/NWBXFszDUQxrIh7v6gwDcX3bPVYQJdY2m6qzuc7u2Xk+3
bgYjOChi+pVK6weOQnu/+1a83Fjg9u9vwCNtIVyTb0Sg3iO4PP6wo+CF0o+mn2rA
jbaMM6QYmNY1TbNBnw0OCAcPtaFA6YqhnocrcBKUKd7gtsyYayMqOIBThBKmR+0T
tjgWySl4dZAP1j2ToxSFEmrgN7yb9oNaKUza0X5u+LDvYmS7TYLhvjdY26OmcxHG
MljeLIYffkSa8ZGAC0U17/I3Zk9tuJhD/hehpO02qK0ZmrG99Zu4r6sUnyt1K60L
jq7UHz4gb2ypS72a1QjcGEGUokOheA==
=K/c4
-----END PGP SIGNATURE-----

--ngZFjV0XBYrCqjZn--


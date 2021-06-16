Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547533AA601
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 23:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhFPVR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 17:17:56 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:22604
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233836AbhFPVRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:17:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWJPYUH9P4WkgMovnkpzqX/w8u4vZUEFTOMvhgXE7oXy3XZfnzH+JlSM4Vt/EDfdQc+IJDEYb8brHOQoCeKZkAvZAs62Z2NpTtTtpWKdJFzO7No34ZzLQ/rGUp/dL1PY3I4Llw8Cq9PKlVE55IMcvfyFPfGhmJpu5LwX++QdB2SPtswH51if0BrF8liUwNEDVbcEu/Kbp0stImRaV5kvhp7Z3BaqcOItkSyzrIB3DzHl6PscL+aMq8KYQF6PkxSl052sCgMnR9PWpW0HMM9MfitLRy5iYv6FssPZZHfK9v4/wVRvwDoY0yfKrNshT5cDDURigXByb5FLsGbYi8SfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EyXrwuwxNraFN6aB7MkuCtaqmIO3Vj+HpYQs7FnA5s=;
 b=geXt+prTb/gan9ZcuVYBwB8q5iu8HXvPA1jfVrusfNe0/jM4ebiVoRJ6FlfSDJLGdoFk1HrXaT8fRja37gHUDECtZqLqI6znlhECBc7hPYoi2Dt0mTpt4EmzgIClSIGIeYEcrkeyswdFtrgH/jjxsKQHEKVexoPUmbDmLE7aoLevefOjbKYE1F2lD6Y2BYerOHrhsHgo2PcmFlGqyEmMq/x9jmJa5gM/L6gZWSIATiUydlk1rLOu6KiJxI/HEy6UskY3jH65a25neQnNp+LYbXQF5OCkCb6SEjDNbXqS6JYKZaL1j1mqMHBVzanIGu3GpCunAjt/GvCB+TFKuPfsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EyXrwuwxNraFN6aB7MkuCtaqmIO3Vj+HpYQs7FnA5s=;
 b=i+ePKXYuIHuzdx8pxCiTj5Hvtis4+fFY92n9vm1kSJOOIR7GS+8lRIRELDQ0EskZN/BVE9LD+ggnAZiBDBFjptfXbcCbVXPfTapcYsVXDZQ5NBWFrpsnLQQyS5IzgPgkjfgBburryNqT/Tm5ZjeNqpfphuOO7qEMnGm789CS5gk=
Received: from DU2PR02MB7573.eurprd02.prod.outlook.com (2603:10a6:10:2d8::6)
 by DU2PR02MB7525.eurprd02.prod.outlook.com (2603:10a6:10:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 16 Jun
 2021 21:15:45 +0000
Received: from DU2PR02MB7573.eurprd02.prod.outlook.com
 ([fe80::551d:b337:e846:73fa]) by DU2PR02MB7573.eurprd02.prod.outlook.com
 ([fe80::551d:b337:e846:73fa%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 21:15:45 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Oded Gabbay <ogabbay@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] habanalabs: add support for dma-buf exporter
Thread-Topic: [PATCH v2 2/2] habanalabs: add support for dma-buf exporter
Thread-Index: AQHXYcPvOwTGTMUc6ki3xIIXlN6OdasU0JyAgAI8UFA=
Date:   Wed, 16 Jun 2021 21:15:45 +0000
Message-ID: <DU2PR02MB7573476D774262F5CDF6206CD20F9@DU2PR02MB7573.eurprd02.prod.outlook.com>
References: <20210615085326.16134-1-ogabbay@kernel.org>
 <20210615085326.16134-2-ogabbay@kernel.org> <YMh038iFBgzx+7aB@kroah.com>
In-Reply-To: <YMh038iFBgzx+7aB@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=habana.ai;
x-originating-ip: [217.132.27.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efc0eace-7fbb-4edb-096a-08d9310be7fb
x-ms-traffictypediagnostic: DU2PR02MB7525:
x-microsoft-antispam-prvs: <DU2PR02MB75252C286E6BB7CD8887A32BD20F9@DU2PR02MB7525.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJoC/p+3BCUGjKd1o+ScN3w8hy68ITi2vKW0+JEfHpZW4uNnFhu7BEHl+/iMFotpMd4HxXFBrStfUJSoUUJ9Tv/qCWFyUuOkT0FkxrdfWbzDrZM7cTOH2VPmoCvz1/rCW9pOx8+SEc3/sY/HZLxXXpYWUMiUfdLVM+cZCKgyTQJdL2xJlKlaMXSX3R0uQP8vMta9x5RW6hUqNBtdjkEocpyCwn4st0qlcHL98dYS8Kb6UCR4X/31gryTApkS0aX2Dbe4MHJqYK28Nb02orcbVXUeilS05/M2P8t6wnalspkoJmMPOW4DZeOtOF4iEjF4MNw9P3hkVs6zJ1DYt2eY/gGQOwHfA9+HQjR3Hq6kn6F102zxVMLWhnGDfduLgy1z3jRJFk949bp38dMmR+q3XPKPR2NuFejAcRoKkWcK0OtonD/xR+9aLWjxnsjAPqBS2KZqfzDhtz0do9tmATjNvcmEXJKHw8AoIRBRqsX86OXuhXBl0F26AYSIVzU3lQLBXjB4MSPSOKke92m1dLKRiR7DWeowc7m9TGOgySNqopFJilLO812dfaoPpj2AiH8YkbFLii62dhAxaNI0Qw6t+y9JXpX00B7sg4FtSy2zKv0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR02MB7573.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39850400004)(136003)(366004)(396003)(346002)(8676002)(8936002)(9686003)(76116006)(55016002)(71200400001)(38100700002)(30864003)(478600001)(4326008)(2906002)(122000001)(66946007)(6506007)(53546011)(5660300002)(186003)(33656002)(52536014)(26005)(110136005)(86362001)(66446008)(66476007)(66556008)(64756008)(7696005)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xF2pwlNg1qWHmMqXGHALjipl9hE2FTm1TRIFxG5CD5zobLNHOxx8x3z5i58W?=
 =?us-ascii?Q?+3QrIKeJ3VMYBAs0F/dVpq8rpa7THCSXFvX8QYZK6owGLdRBWkujTwQcA8Xq?=
 =?us-ascii?Q?zp/x2DhCFCaWA6Q3kcbva67D53OBVjakQdjsbkGumKmk9EvU3gfLzQMNl7p1?=
 =?us-ascii?Q?VZH6PkkUW1A3cRZyWGsx06HlmqjU3zlIeK/KNEvVSFaQliUl4MIlZC21DJbI?=
 =?us-ascii?Q?HZ1Yqj6VBSWqac+fSKG/EAsha7MjiwnWczuFOs5y8uNYCzMSbVMRhv8lYs1g?=
 =?us-ascii?Q?A8VZiM8YKeeVl2LPvneSjWDbqygUoLFdMNGc+D3uNpC1yqvCghYHLKEyg4ix?=
 =?us-ascii?Q?8jwpF07/hU5KguL729Hzuqgwxm7TjJJDbHnrPcI9VDrL6iWcraTpLRS63dnN?=
 =?us-ascii?Q?63wGsQiL7o+v/nGfH9ZIeuYDnbOt0DK+ERiqi2BKw+7VSV6t3wiRbrhNvSoW?=
 =?us-ascii?Q?RBUm8Hr/iFOOuYK9fm27lwa8DZ2D2AIWd+pbMsYlJ0A/k6ReLIlIw6jp8/mL?=
 =?us-ascii?Q?T2gx3MGlm6bpPsMZ2qChqmSc15nrV9IfVM4wue76g7Tgcjw1ev4ZL22vLSka?=
 =?us-ascii?Q?p0wLI8gNK5mTsrdveBPcVU3wBlqiKYjTnsN7sK9q4MLFbNtznZCU3s7dcUCu?=
 =?us-ascii?Q?BT541fGL9gesrb0yYZh4c2SOAQtpDkaN99YVZgivLowLTbzICStDVqukTvWw?=
 =?us-ascii?Q?ceQ4tyHdOc/S6YHZOPdQA49jJPivtq8k4kAs8AYAraEwAdpgdpYGOpxXSHXV?=
 =?us-ascii?Q?k8ZSrGCTh1HyXxtmx8MYYqfjiNvet3f60zswdLzt5Dyb1W4XNfPf4tAS2uKy?=
 =?us-ascii?Q?FI1OXZsJ3Y5r4OnJuTyTG9P4tJlTTkl/RKPEzZ/XntID2BIDGF8FGbkb9feA?=
 =?us-ascii?Q?6aLYPnoFpKxV3AVUQzH8xZt/ZcCE9z4sr6mIJMkwmKKAV3UD+DkwFLZftScR?=
 =?us-ascii?Q?nEwJNNBAUJvaK/896Te9mAPQrEoFmzvQFKgoNbtUTTbBVXT5p/5SNYrSvBGn?=
 =?us-ascii?Q?quoEgfFnS8OinBGnn+IreM9BxwPFcDU2aIEWVuVHgR+5nW3rwHq3zvtL8HUR?=
 =?us-ascii?Q?mZDuFvGuC2nxMMxnXq35wZmsFP/G6AUfTA6FPkJuSVTItS7Mdx1b2uo6ORDE?=
 =?us-ascii?Q?ZLV9o1MmZBCv+7/l7e7lOJZpTennfCITSROvasUmi3/dQwvBOEvS+FrJNxMG?=
 =?us-ascii?Q?TyX34XKaxhSlUFUrml5/4dz33BHE9mmvOOYXPqWKzh6Gw0igzen7XJf6958O?=
 =?us-ascii?Q?vxjJWkxhUz3hRfHY7Gn/xE8nHZwX492LuRRDhEfJuoJzvRzrgfTPfF+4uTmz?=
 =?us-ascii?Q?yorUPe41fzTGbZyUpof1632m?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR02MB7573.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc0eace-7fbb-4edb-096a-08d9310be7fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 21:15:45.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzoSayxpWkEP/hWKmeGaqyxN1lGiHFjZ7wPyTm79v19ov1AlZyCMHKlV+z3CTgnzZXLCSjZr8Bn/mp2QSg36Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB7525
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:38 AM, Greg KH wrote:
> On Tue, Jun 15, 2021 at 11:53:26AM +0300, Oded Gabbay wrote:
> > +struct hl_dmabuf_wrapper {
> > +	struct dma_buf			*dmabuf;
> > +	struct hl_ctx			*ctx;
> > +	struct hl_vm_phys_pg_pack	*phys_pg_pack;
> > +	struct list_head		node;
> > +	struct sg_table			sgt;
> > +	u64				total_size;
> > +	u64				handle;
> > +	int				fd;
>=20
> As this reflects the __u64 you send to userspace, shouldn't the fd also b=
e u64
> here?  Or does it really not matter?

This fd is actually used only for debug prints and we'll remove it.

> > @@ -1598,6 +1626,7 @@ struct hl_vm_hw_block_list_node {
> >   * @npages: num physical pages in the pack.
> >   * @total_size: total size of all the pages in this list.
> >   * @mapping_cnt: number of shared mappings.
> > + * @exporting_cnt: number of dma-buf exporting.
> >   * @asid: the context related to this list.
> >   * @page_size: size of each page in the pack.
> >   * @flags: HL_MEM_* flags related to this list.
> > @@ -1612,6 +1641,7 @@ struct hl_vm_phys_pg_pack {
> >  	u64			npages;
> >  	u64			total_size;
> >  	atomic_t		mapping_cnt;
> > +	atomic_t		exporting_cnt;
>=20
> Shouldn't this just be a refcount_t?  It seems like you are treating it l=
ike one.
>=20
> > @@ -347,6 +354,13 @@ static int free_device_memory(struct hl_ctx *ctx,
> struct hl_mem_in *args)
> >  			return -EINVAL;
> >  		}
> >
> > +		if (atomic_read(&phys_pg_pack->exporting_cnt) > 0) {
> > +			dev_err(hdev->dev,
> > +				"handle %u is exported, cannot free\n",
> 	handle);
>=20
> What prevents the count from changing right after you read it?  This usua=
lly
> feels wrong.  What protects this from happening?
>=20
> > +			spin_unlock(&vm->idr_lock);
>=20
> Ah, the lock?  Then why is this atomic?

That's correct, will modify it to a regular variable.
refcount_t might be less suitable here, because we don't necessarily releas=
e the phys_pg_pack object when it not exported.
=20
> > +static int hl_dmabuf_attach(struct dma_buf *dmabuf,
> > +				struct dma_buf_attachment *attachment) {
> > +	struct hl_dmabuf_wrapper *hl_dmabuf =3D dmabuf->priv;
> > +	struct hl_device *hdev =3D hl_dmabuf->ctx->hdev;
> > +
> > +	dev_dbg(hdev->dev, "attaching dma-buf, handle 0x%llx, fd %d\n",
> > +		hl_dmabuf->handle, hl_dmabuf->fd);
> > +
> > +	attachment->priv =3D hl_dmabuf;
> > +
> > +	return 0;
> > +}
> > +
> > +static void hl_dmabuf_detach(struct dma_buf *dmabuf,
> > +				struct dma_buf_attachment *attachment) {
> > +	struct hl_dmabuf_wrapper *hl_dmabuf =3D dmabuf->priv;
> > +	struct hl_device *hdev =3D hl_dmabuf->ctx->hdev;
> > +
> > +	dev_dbg(hdev->dev, "detaching dma-buf, handle 0x%llx, fd %d\n",
> > +		hl_dmabuf->handle, hl_dmabuf->fd);
>=20
> Nothing needs to happen in detach?
>=20
> Not clearing ->priv?
>=20
> If not, why have this callback at all?

We do need to clear attachment->priv. Missed that, thanks.

> > +static struct sg_table *hl_map_dmabuf(struct dma_buf_attachment
> *attachment,
> > +					enum dma_data_direction dir)
> > +{
> > +	struct hl_dmabuf_wrapper *hl_dmabuf =3D attachment->priv;
> > +	struct hl_device *hdev =3D hl_dmabuf->ctx->hdev;
> > +
> > +	dev_dbg(hdev->dev, "mapping dma-buf, handle 0x%llx, fd %d\n",
> > +		hl_dmabuf->handle, hl_dmabuf->fd);
> > +
> > +	return &hl_dmabuf->sgt;
> > +}
> > +
> > +static void hl_unmap_dmabuf(struct dma_buf_attachment *attachment,
> > +				  struct sg_table *table,
> > +				  enum dma_data_direction dir)
> > +{
> > +	struct hl_dmabuf_wrapper *hl_dmabuf =3D attachment->priv;
> > +	struct hl_device *hdev =3D hl_dmabuf->ctx->hdev;
> > +
> > +	dev_dbg(hdev->dev, "unmapping dma-buf, handle 0x%llx, fd %d\n",
> > +		hl_dmabuf->handle, hl_dmabuf->fd);
>=20
> Same here, why have this?

unmap is a mandatory op and it is enforced in dma_buf_export().
Will add a clear comment why we add an empty callback.

> > +static void hl_release_dmabuf(struct dma_buf *dmabuf) {
> > +	struct hl_dmabuf_wrapper *hl_dmabuf =3D dmabuf->priv;
> > +	struct hl_ctx *ctx =3D hl_dmabuf->ctx;
> > +	struct hl_device *hdev =3D ctx->hdev;
> > +
> > +	dev_dbg(hdev->dev, "releasing dma-buf, handle 0x%llx, fd %d\n",
> > +		hl_dmabuf->handle, hl_dmabuf->fd);
>=20
> You do know about ftrace, right?  :)
>=20
> These debugging lines should all now be removed.
>=20
> > +/**
> > + * export_dmabuf_from_addr() - export a dma-buf object for the given
> memory
> > + *                             address and size.
> > + * @ctx: pointer to the context structure.
> > + * @device_addr:  device memory physical address.
> > + * @size: size of device memory.
> > + * @flags: DMA-BUF file/FD flags.
> > + * @dmabuf_fd: pointer to result FD that represents the dma-buf object=
.
> > + *
> > + * Create and export a dma-buf object for an existing memory
> > +allocation inside
> > + * the device memory, and return a FD which is associated with the
> > +dma-buf
> > + * object.
> > + *
> > + * Return: 0 on success, non-zero for failure.
> > + */
> > +static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 device_addr=
,
> > +					u64 size, int flags, int *dmabuf_fd) {
> > +	struct hl_device *hdev =3D ctx->hdev;
> > +	struct asic_fixed_properties *prop =3D &hdev->asic_prop;
> > +	struct hl_dmabuf_wrapper *hl_dmabuf;
> > +	int rc;
> > +
> > +	dev_dbg(hdev->dev, "exporting dma-buf for addr 0x%llx, size
> 0x%llx\n",
> > +			device_addr, size);
>=20
> Again, ftrace is your friend.

These dev_dbg calls are leftover of a debug code ... will remove them.

> > +
> > +	if (!IS_ALIGNED(device_addr,
> DMA_BUF_MEM_ADDR_ALIGNMENT)) {
>=20
> How can this happen?
>=20
> > +		dev_err(hdev->dev,
> > +			"address of exported device memory should be
> aligned to 0x%x, address 0x%llx\n",
> > +			DMA_BUF_MEM_ADDR_ALIGNMENT, device_addr);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!size) {
> > +		dev_err(hdev->dev,
> > +			"size of exported device memory should be greater
> than 0\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!IS_ALIGNED(size, DMA_BUF_MEM_SIZE_ALIGNMENT)) {
>=20
> Why would size need to be "aligned"?

In the general case it cannot happen, as the kernel driver is responsible f=
or the device memory allocation.
However in Gaudi device there is no MMU towards the device memory and user =
works on physical addresses,
and thus he can provide any address and any size.
If this memory is too big for a SG list entry we need to split it into smal=
ler chunks.
To simplify things and avoid dealing with issues like which new chunk size =
to use and how to handle remainders,
we enforce address/size alignments so a split can be done easily.

>=20
> > +		dev_err(hdev->dev,
> > +			"size of exported device memory should be aligned
> to 0x%x, size 0x%llx\n",
> > +			DMA_BUF_MEM_SIZE_ALIGNMENT, device_addr);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (device_addr < prop->dram_user_base_address ||
> > +			device_addr + size > prop->dram_end_address) {
> > +		dev_err(hdev->dev,
> > +			"DRAM memory range is outside of DRAM
> boundaries, address 0x%llx, size 0x%llx\n",
> > +			device_addr, size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	hl_dmabuf =3D kzalloc(sizeof(*hl_dmabuf), GFP_KERNEL);
> > +	if (!hl_dmabuf)
> > +		return -ENOMEM;
> > +
> > +	hl_dmabuf->handle =3D device_addr;
> > +	hl_dmabuf->total_size =3D size;
> > +
> > +	rc =3D export_dmabuf_common(ctx, hl_dmabuf, &device_addr, 1, size,
> flags,
> > +					dmabuf_fd);
> > +	if (rc)
> > +		goto err_free_dmabuf_wrapper;
> > +
> > +	return 0;
> > +
> > +err_free_dmabuf_wrapper:
> > +	kfree(hl_dmabuf);
> > +	return rc;
> > +}
> > +
> > +/**
> > + * export_dmabuf_from_handle() - export a dma-buf object for the given
> memory
> > + *                               handle.
> > + * @ctx: pointer to the context structure.
> > + * @handle: device memory allocation handle.
> > + * @flags: DMA-BUF file/FD flags.
> > + * @dmabuf_fd: pointer to result FD that represents the dma-buf object=
.
> > + *
> > + * Create and export a dma-buf object for an existing memory
> > +allocation inside
> > + * the device memory, and return a FD which is associated with the
> > +dma-buf
> > + * object.
> > + *
> > + * Return: 0 on success, non-zero for failure.
> > + */
> > +static int export_dmabuf_from_handle(struct hl_ctx *ctx, u64 handle, i=
nt
> flags,
> > +					int *dmabuf_fd)
> > +{
> > +	struct hl_device *hdev =3D ctx->hdev;
> > +	struct hl_vm_phys_pg_pack *phys_pg_pack;
> > +	struct hl_dmabuf_wrapper *hl_dmabuf;
> > +	struct hl_vm *vm =3D &hdev->vm;
> > +	enum vm_type_t *vm_type;
> > +	u32 idr_handle;
> > +	int rc;
> > +
> > +	dev_dbg(hdev->dev, "exporting dma-buf for handle 0x%llx\n",
> handle);
> > +
> > +	idr_handle =3D lower_32_bits(handle);
> > +
> > +	spin_lock(&vm->idr_lock);
> > +
> > +	phys_pg_pack =3D idr_find(&vm->phys_pg_pack_handles,
> idr_handle);
> > +	if (!phys_pg_pack) {
> > +		spin_unlock(&vm->idr_lock);
> > +		dev_err(hdev->dev, "no match for handle 0x%x\n",
> idr_handle);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* increment now to avoid freeing device memory while exporting */
> > +	atomic_inc(&phys_pg_pack->exporting_cnt);
>=20
> Looks like you do this under a lock, so why have this be atomic at all?
>=20
> > +
> > +	spin_unlock(&vm->idr_lock);
> > +
> > +	vm_type =3D (enum vm_type_t *) phys_pg_pack;
> > +	if (*vm_type !=3D VM_TYPE_PHYS_PACK) {
> > +		dev_err(hdev->dev, "handle 0x%llx is not for DRAM
> memory\n",
> > +				handle);
> > +		rc =3D -EINVAL;
> > +		goto err_dec_exporting_cnt;
> > +	}
> > +
> > +	hl_dmabuf =3D kzalloc(sizeof(*hl_dmabuf), GFP_KERNEL);
> > +	if (!hl_dmabuf) {
> > +		rc =3D -ENOMEM;
> > +		goto err_dec_exporting_cnt;
> > +	}
> > +
> > +	hl_dmabuf->phys_pg_pack =3D phys_pg_pack;
> > +	hl_dmabuf->handle =3D handle;
> > +	hl_dmabuf->total_size =3D phys_pg_pack->total_size;
> > +
> > +	rc =3D export_dmabuf_common(ctx, hl_dmabuf, phys_pg_pack-
> >pages,
> > +				phys_pg_pack->npages, phys_pg_pack-
> >page_size,
> > +				flags, dmabuf_fd);
> > +	if (rc)
> > +		goto err_free_dmabuf_wrapper;
> > +
> > +	return 0;
> > +
> > +err_free_dmabuf_wrapper:
> > +	kfree(hl_dmabuf);
> > +err_dec_exporting_cnt:
> > +	atomic_dec(&phys_pg_pack->exporting_cnt);
>=20
> No lock here?

Will modify to a regular variable and add a lock where missing.

>=20
> > +	return rc;
> > +}
> > +
> >  static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args
> > *args)  {
> >  	struct hl_device *hdev =3D hpriv->hdev;
> >  	struct hl_ctx *ctx =3D hpriv->ctx;
> >  	u64 block_handle, device_addr =3D 0;
> >  	u32 handle =3D 0, block_size;
> > -	int rc;
> > +	int rc, dmabuf_fd =3D -EBADF;
> >
> >  	switch (args->in.op) {
> >  	case HL_MEM_OP_ALLOC:
> > @@ -1471,6 +1863,16 @@ static int mem_ioctl_no_mmu(struct hl_fpriv
> *hpriv, union hl_mem_args *args)
> >  		args->out.block_size =3D block_size;
> >  		break;
> >
> > +	case HL_MEM_OP_EXPORT_DMABUF_FD:
> > +		rc =3D export_dmabuf_from_addr(ctx,
> > +				args->in.export_dmabuf_fd.handle,
> > +				args->in.export_dmabuf_fd.mem_size,
> > +				args->in.flags,
> > +				&dmabuf_fd);
> > +		memset(args, 0, sizeof(*args));
> > +		args->out.fd =3D dmabuf_fd;
>=20
> No need to copy_to_user()?
>=20
> > +		break;
> > +
> >  	default:
> >  		dev_err(hdev->dev, "Unknown opcode for memory
> IOCTL\n");
> >  		rc =3D -ENOTTY;
> > @@ -1489,7 +1891,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void
> *data)
> >  	struct hl_ctx *ctx =3D hpriv->ctx;
> >  	u64 block_handle, device_addr =3D 0;
> >  	u32 handle =3D 0, block_size;
> > -	int rc;
> > +	int rc, dmabuf_fd =3D -EBADF;
> >
> >  	if (!hl_device_operational(hdev, &status)) {
> >  		dev_warn_ratelimited(hdev->dev,
> > @@ -1580,6 +1982,22 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void
> *data)
> >  		args->out.block_size =3D block_size;
> >  		break;
> >
> > +	case HL_MEM_OP_EXPORT_DMABUF_FD:
> > +		if (hdev->asic_prop.dram_supports_virtual_memory)
> > +			rc =3D export_dmabuf_from_handle(ctx,
> > +					args->in.export_dmabuf_fd.handle,
> > +					args->in.flags,
> > +					&dmabuf_fd);
> > +		else
> > +			rc =3D export_dmabuf_from_addr(ctx,
> > +					args->in.export_dmabuf_fd.handle,
> > +					args-
> >in.export_dmabuf_fd.mem_size,
> > +					args->in.flags,
> > +					&dmabuf_fd);
> > +		memset(args, 0, sizeof(*args));
> > +		args->out.fd =3D dmabuf_fd;
>=20
> Same here, no need to copy_to_user()?

There is a wrapping hl_ioctl() function that calls copy_to_user().

>=20
> thanks,
>=20
> greg k-h

Thanks

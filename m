Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE83098CE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhA3X0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 18:26:24 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41107 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230360AbhA3X0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:26:23 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E4D2D5C00DB;
        Sat, 30 Jan 2021 18:25:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 30 Jan 2021 18:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=uGSJdj
        Lm7T/PXU4iFWHQXgTBYpqhY1DOdD1iQ5TPgmw=; b=gzLNUDBctOiHUBw5c7UHV3
        gIF1yG63lLoaWN5GPM+AmhzT1jgIrsRYTQr8tjEC+h3+dfciA++moXtbvebyS37a
        oH+VfQX5tWQjddBPe+rWEnto/OrrrHDaQgFMVuQcuVbNiY9f30cqYtNjKCbzfUzT
        y3BfAxu4vUQIEZZB7RGaSM1SIUy6N1ZaV9JB55YJmXIe2Bij/0/+sZVpe92QLi5R
        lBMC66aWCgwhTBxB/tc0hQgvqxFcz3AnITx+MjsWcDIDi7baqCAcDWpaA5OqyzAo
        LN5NyYhTVSHdhDKURcF/Nhu2+2uXJinuRJT/M5ohQE9Xqjke/dbuM7UeCp7ag7Wg
        ==
X-ME-Sender: <xms:3OoVYLi5LTu62OcKn0dxanXVHQVtnCL4izW9UM3Tw-GdF_riV7n2oQ>
    <xme:3OoVYH_kaHWcNpgTqMJyTo0pPoi_SPoF4mmJ_j2tukVCde59S2ooU_7gL9KTrjvW6
    nmYPFLtopUUig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepheevvdeu
    veehkeehhfevgffggfevudegteeugfeliedvhefgueeiuefgteetieffnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphepledurdeigedrudejtddrkeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghkse
    hinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:3OoVYH9ZLKNiwTtPoIPt4HgdLY-Kf_d-Uqxfy8d_ThrnrcsYyemRdg>
    <xmx:3OoVYAAiCbejjttzqOXt5CEkeH85DfQy6AbzPDKCM8O2roH730pScQ>
    <xmx:3OoVYHyDboqPGnQcGUJMHvaakeJAn8pbDlemB9axroeNozW8FzOvkg>
    <xmx:3OoVYMPXVaQcwYdeT9sTiXvX0GW5g-lcPFo9jPWhDZGTiFMmAqpL1Q>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de [91.64.170.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8961D108005F;
        Sat, 30 Jan 2021 18:25:15 -0500 (EST)
Date:   Sun, 31 Jan 2021 00:25:13 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Michael Labriola <michael.d.labriola@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sasha Levin <sashal@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: Problems starting Xen domU after latest stable update
Message-ID: <20210130232513.GA6354@mail-itl>
References: <2nft2kipqg.fsf@aragorn.infrastructure.cah>
 <983b87d6-edb8-21ea-7d6f-f653f5c0d048@oracle.com>
 <20210129005129.GA2452@mail-itl>
 <44068a70-8940-824b-9e39-b800635b92c7@suse.com>
 <CAOQxz3w-2aJn1dKbQRG8_m8f3_pN0zSXzYkfyU7cvo34vF6P=g@mail.gmail.com>
 <16a2f371-1c39-13f5-c214-e054b08abbab@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <16a2f371-1c39-13f5-c214-e054b08abbab@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Problems starting Xen domU after latest stable update

On Fri, Jan 29, 2021 at 03:16:52PM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> On 29.01.21 15:13, Michael Labriola wrote:
> > On Fri, Jan 29, 2021 at 12:26 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com=
> wrote:
> > > If the buggy patch has been put into stable this Fixes: tag should
> > > result in the fix being put into the same stable branches as well.
> >=20
> > I've never done this before...  does this happen automatically?  Or is
> > there somebody we should ping to make sure it happens?
>=20
> This happens automatically (I think).
>=20
> I have seen mails for the patch been taken for 4.14, 4.19, 5.4 and 5.10.

Hmm, I can't find it in LKML archive, nor stable@ archive. And also it
isn't included in 5.10.12 released yesterday, nor included in
queue/5.10 [1]. Are you sure it wasn't lost somewhere in the meantime?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Dqueue/5.10

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmAV6tgACgkQ24/THMrX
1yz3dgf+P66i0RjhvZfO1Cg+lbVdwhli7NGBDS5ILY4CdlKQzwYhlHtlbehX2Jt1
fZ6eipZUkFytBbSXViCruBXXwbTF1VCZWUtyhUSKLWxt1hl4ACUW39iP8QWoOF2/
NfdaVdd1j+ZTXDNX74D5uBEGD/oDMnxENGOm4as005FC6WYwvYk7FO9F2mLzvcmp
BVWyOvOhxrE42h9EnSgQIbEQ94OdrN9KAQc0sFSwQUZm3YkgplSbxQUuSCnYR+iD
uOJxJTG5zcvq/Sk4V5wnUVRUewToVk8rC7rYMI1Lnqopuv9/cKcS5diQIRPcoPtU
hZFlGHSxZAFlRF4OioJoqvn7ZGJgYg==
=i1Z2
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

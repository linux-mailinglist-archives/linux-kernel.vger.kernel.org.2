Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0EF41A63A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 05:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhI1D5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 23:57:31 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:59541 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbhI1D5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 23:57:30 -0400
Date:   Tue, 28 Sep 2021 03:55:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1632801350;
        bh=z1qNPQYLno566jNlHm1NK9hDE1ClX3aiY9sUnHP8IGA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=FpyjKWYUTJZEzCBq/l98SDJXyUebazy9Isq1zrQEeV/tSAKAbZ24ol8uQng33ZeKe
         jvqQPcGb+vbQoCLw1b8s4I/4bbKqO1IFnzWlWpYDZIYX2bLsjTcY9gml0CxprwHIln
         sTMypClLOazy8Onpb6HLG+pqc42wYq4m0iUQkXcQ=
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Sven Peter <sven@svenpeter.dev>,
        Aditya Garg <gargaditya08@live.com>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
Message-ID: <38101793-e0b9-ecf4-d235-465cb8e334b3@protonmail.com>
In-Reply-To: <20210927154306.387437-1-kbusch@kernel.org>
References: <20210927154306.387437-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/9/21 01:43, Keith Busch wrote:
> Some apple controllers use the command id as an index to implementation
> specific data structures and will fail if the value is out of bounds.
> The nvme driver's recently introduced command sequence number breaks
> this controller.
>=20
> Provide a quirk so these spec incompliant controllers can function as
> before. The driver will not have the ability to detect bad completions
> when this quirk is used, but we weren't previously checking this anyway.
>=20
> The quirk bit was selected so that it can readily apply to stable.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D214509
> Cc: Sven Peter <sven@svenpeter.dev>
> Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
> Reported-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2: fixed logical bug checking the quirk setting
>=20
>  drivers/nvme/host/core.c | 4 +++-
>  drivers/nvme/host/nvme.h | 6 ++++++
>  drivers/nvme/host/pci.c  | 3 ++-
>  3 files changed, 11 insertions(+), 2 deletions(-)

Works on my MacBookPro16,1.

Tested-by: Orlando Chamberlain <redecorating@protonmail.com>


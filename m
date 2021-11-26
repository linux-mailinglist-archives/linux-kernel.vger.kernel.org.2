Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9049845F315
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhKZRnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhKZRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:41:49 -0500
X-Greylist: delayed 364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 09:16:29 PST
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DACC061374;
        Fri, 26 Nov 2021 09:16:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEFE3622DB;
        Fri, 26 Nov 2021 17:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D92C93056;
        Fri, 26 Nov 2021 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637946645;
        bh=ykvKBN4CBIiV/C4XvlxkMrRC1hRjKK7PgdIL1GT0O+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RpL8dalrfCGQnhCJl3uzwnjOIw8U/K5ceMfnKXV3EvOxfWATsQ35xuL1h+RKSy1LK
         ebbTAv/GPbCc4aaEbjTM43pg7d/z+vnGIJzgXJDJ+5umFcWkbx/tcpRDFG0i+/1+Ne
         ulRrBsBEpnZD+EjjQ7VhhQAgAjGZzG9cTqqHg/mXpfgeQS8Cc9dFzQw1hfNYVUUMFG
         CduTKEkFGxfJwMivfDH0UqWgDNzRhqXqZ4/JXV9yeFgvpMZ0ZAmOOfCNNR0FbhZJ/T
         CB5vv3yDEUs2x+/mG/YY6UMSzZggK17OHwHIwn5gcK1mxEHllb5EOXaWIq0esGcPMh
         A98srwnNwWK8w==
Date:   Fri, 26 Nov 2021 18:10:40 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB
 device tree
Message-ID: <20211126181040.7a5cdea1@thinkpad>
In-Reply-To: <20211018011211.3836590-3-chris.packham@alliedtelesis.co.nz>
References: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
        <20211018011211.3836590-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 14:12:11 +1300
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> The CN9130-CRB boards have a MV88E6393X switch connected to eth0. Add
> the necessary dts nodes and properties for this.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

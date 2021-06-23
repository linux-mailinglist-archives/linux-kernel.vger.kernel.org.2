Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24F53B20D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFWTPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 15:15:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53301 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWTPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 15:15:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85FD9DB42F;
        Wed, 23 Jun 2021 15:12:54 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=2wSwZoUV0BkpVfQ4NaFgz9pv1d03ftI8MRES2Cx
        KeXU=; b=W5ii4S8W2nF3Yh/MqkoiUjZteR9HTm016zp43rfsQGTnJ3ztJ9alZyW
        OSY5CJp7Yk6Hlgu0iejWWmSfHOlPjvtESAvJNNmtFboWXhbFTuK2QkAXsiZDg2VC
        0mNQ9dSr5+G1eOpOfcEdY+6zynrZYkdLdy/4uWeSFBWAFVPERlpE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EAB3DB42D;
        Wed, 23 Jun 2021 15:12:54 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=2019-09.pbsmtp; bh=2wSwZoUV0BkpVfQ4NaFgz9pv1d03ftI8MRES2CxKeXU=; b=TQeTHrj9QsMNgeYWeJpq4+fA6AnaTuIoh6xFJvmCNIZdDFJ0X8OxZpn0W3+7u7TcNrL6vk1PFXH8gqBstGyhaSvpYImSSe2rWvrDeKbwwW3ih1af/rk7X3P7SDi1OuzhPy+ZYA3Em6l3bOgUu5+esZUXQSsZP7xemX9u0JihqM8=
Received: from oatmeal.darkphysics (unknown [24.19.107.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79E5ADB42C;
        Wed, 23 Jun 2021 15:12:53 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 23 Jun 2021 12:12:46 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] net/e1000e: Fix spelling mistake "The" -> "This"
Message-ID: <20210623191245.GA32122@oatmeal.darkphysics>
References: <20210622221938.GA30762@oatmeal.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622221938.GA30762@oatmeal.darkphysics>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Pobox-Relay-ID: 02C8137C-D457-11EB-9BB5-8B3BC6D8090B-45285927!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 03:19:40PM -0700, Tree Davies wrote:
> There is a spelling mistake in the comment block.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 88e9035b75cf..ff267cf75ef8 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -7674,7 +7674,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   * @pdev: PCI device information struct
>   *
>   * e1000_remove is called by the PCI subsystem to alert the driver
> - * that it should release a PCI device.  The could be caused by a
> + * that it should release a PCI device.  This could be caused by a
>   * Hot-Plug event, or because the driver is going to be removed from
>   * memory.
>   **/
> -- 
> 2.20.1
>

Adding linux-kernel@  

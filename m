Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633053A9DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhFPOkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233563AbhFPOkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:40:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ACB261107;
        Wed, 16 Jun 2021 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623854291;
        bh=ccgGS6MIcePXdV7ZdGlih8AG9waTonXlVIKwYh1g7Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/c0uLzbuZ4iu3EDvA8wG6xRgc86MA52Dz2FHGXY6biK1PE38S8KeUma7QDxnQUPp
         t4iaX7vujdw2QYqVsqmZcpHYNu6OH7opB+Oi76OQ5KRYV8pnuvV959MmruxfWpZKO4
         madlKlThdMuXcgUqw8b0vMfQtJrKq/u5qIAHuNCnQiiuzH8cfC+NqdTqyREAsr7Ai4
         HfeNMIzy/zpNpyu44NmB0NcbbfU1gCVCHyHPOCjqE8et4jnAPyGxzqNjnRSfQkI8x5
         zTck0svHneAJq/abolyN0rKcFPD25FUpf2ocdkoriB4iwE9FDKEzL9rDnzDIebsPiB
         6EsHLk36FvtHA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ltWgB-0000wZ-Sy; Wed, 16 Jun 2021 16:38:08 +0200
Date:   Wed, 16 Jun 2021 16:38:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tung Pham <Tung.Pham@silabs.com>
Cc:     tu pham <thanhtung1909@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: Re: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YMoMz3/V93hNxzRt@hovoldconsulting.com>
References: <20210426091244.19994-1-tupham@silabs.com>
 <YMITDyLtcPinbHMv@hovoldconsulting.com>
 <CO1PR11MB48824009354B8A336441B86A81329@CO1PR11MB4882.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48824009354B8A336441B86A81329@CO1PR11MB4882.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 09:45:47AM +0000, Tung Pham wrote:
> Dear Johan.
> I 'm sorry about my less of experience about committing patch to Linux
> kernel, causing you take so much time to review.
> I'll document your comment and last commit by you as a reference for
> my next commit if I have in the future.

Sounds good.

> Thanks you for your effort.

You're welcome.

Johan

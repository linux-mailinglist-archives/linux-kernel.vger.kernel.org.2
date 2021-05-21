Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A3938C165
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhEUIJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhEUIJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 691E66135B;
        Fri, 21 May 2021 08:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621584424;
        bh=Dh4iaemgZiP+sI4zLgG+IjrXf7s+qmocnmFhVrJe81o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scMA1S5jdFFSFrho1vzEp9G6EW9seA7kz0haCG9k9P5U+sKu9OyKJqTD438vS/ds2
         zKgwKPAzriKd9t5IJcT15qu0itf4NCaMX/NIsCZuVo4WL0xQQcJrmZFO4etgEZsTLT
         Xdk/X+e/cw2KMLwjMdtFfqa8HOC11GkFMXE80Gfy39EQccotz2NS/OcR4mRZupPfgL
         mEOmiQwOlTiEz7bkM9tr4a0HyjTTMoKm2yBf90ZhfUuZblZ4mK3uvxPQ75U5KkmFE5
         NnZJg/n0pcswQRgaHBj2O3d9UE5EsZXnfxH8fA3uJBtDyLsUgpO4M8MsHgKP/nUl0a
         qAFvXneW1zbyA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lk0BU-0004yw-Lp; Fri, 21 May 2021 10:07:04 +0200
Date:   Fri, 21 May 2021 10:07:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tung Pham <Tung.Pham@silabs.com>
Cc:     Pho Tran <photranvan0712@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: Re: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YKdqKDj/Qbw4k5IA@hovoldconsulting.com>
References: <CO1PR11MB488255D1B04D3B90886A59BE812C9@CO1PR11MB4882.namprd11.prod.outlook.com>
 <YKNnBckiw4fLIuQL@hovoldconsulting.com>
 <CO1PR11MB4882BE3951A2CDFC8F060B58812A9@CO1PR11MB4882.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4882BE3951A2CDFC8F060B58812A9@CO1PR11MB4882.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 03:11:54PM +0000, Tung Pham wrote:

> On Tue, May 18, 2021 at 03:18:06AM +0000, Tung Pham wrote:

> > Do you agree and approve with this path?.
> 
> > I'm still waiting for you to confirm that you have tested the patch
> > with different pin configurations in eeprom.

> -> we have tested pass the GPIO of cp2108:
> Case1: all 16 GPIO are configured as GPIO function.
> Case2: all 16 GPIO are configured as alternative functions (not GPIO).
> Please see attached file for more detail.

Excellent, thanks for confirming. I'll try to review the latest revision
shortly.

Johan

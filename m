Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2856E3DC398
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 07:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhGaFmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 01:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhGaFmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 01:42:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF80960F3A;
        Sat, 31 Jul 2021 05:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627710136;
        bh=IwVdrcfrdnNBH5U7lEgDkwneMomT5Y6lXiudXizDKuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzcYZkZ9KWEMYbKI0VUjqijNPMC/yN42fx+ZhgISlXtsXSNdiqBonUmHfUl8K9qIL
         2Cx8yX1/bAqaufXenEx9pIGiWQBjs8qBUNmSc1nzSXAW+1edz0XchourtvVux07Rqo
         A5zbAKk8thJx7o6GX6RclrQrGMcKlSAWWIgbLtQk=
Date:   Sat, 31 Jul 2021 07:42:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Embedded USB Debug(EUD) driver
Message-ID: <YQTitrc49G7RxYi2@kroah.com>
References: <CAPY=qRS0F0iv15w34w13xutoUThbDqFtYniM=eLLmqaMdXya3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY=qRS0F0iv15w34w13xutoUThbDqFtYniM=eLLmqaMdXya3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 11:33:09PM +0530, Subhashini Rao Beerisetty wrote:
> Hi All,
> 
> I'm currently looking for the Embedded USB Debug (EUD) interface driver.

For what specific hardware?  Do you have the needed "special" cable?  We
have support in the kernel for some types of these cables, what kernel
versions have you tried that did not work for this?

thanks,

greg k-h

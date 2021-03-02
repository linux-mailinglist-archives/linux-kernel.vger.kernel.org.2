Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A032A7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579252AbhCBQqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448343AbhCBOUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:20:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7670061494;
        Tue,  2 Mar 2021 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614694684;
        bh=I/FQ9LFSJeF74MSp89Y15IZhKpU0lL+OIeFn8C9olrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftWy7f1Ej2tg+oVxCuisxa+yTR9QQIJbDGHCnu0xudnU/viwtGN81KcE+hMb4r9Qu
         TnSeLTLvYrHZuR2GqdIaUz+MZSf41c4xHJW9QV2CZtoP8VNNZ5pzULLSXfeVPx0I6+
         S309gYkpBiu5u3PHRYC5dIjsNMcwu8qBCBJ5ki2Y=
Date:   Tue, 2 Mar 2021 15:18:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Darryl T. Agostinelli" <dagostinelli@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u avoid flex array of flex array
Message-ID: <YD5JGYK3IxVVbULa@kroah.com>
References: <20210228010614.162998-1-dagostinelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228010614.162998-1-dagostinelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 07:06:14PM -0600, Darryl T. Agostinelli wrote:
> Undo the flex array in struct ieee80211_info_element.  It is used as the flex
> array type in other structs (creating a flex array of flex arrays) making
> sparse unhappy.  This change maintains the intent of the code and satisfies
> sparse.

We have been trying to convert the kernel to use the [] style over time,
please don't move backwards on this.  There are loads of commits by
Gustavo in the tree that show this work.

thanks,

greg k-h

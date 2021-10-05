Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9124224A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhJELJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234227AbhJELJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:09:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17FE961139;
        Tue,  5 Oct 2021 11:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633432080;
        bh=8O4NbzI83W4MmE7yBDBAt3SGlFnFr044fTTajdBRZjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVUyO5b7dn6kniwvljrzctepL71uRP7zMmqY759v7eUGFpvem6FDZ//ruqnRgZQaB
         ZyNQGcg8NxCAi552kbDFl5rz2SC2o1vpnTSA9Scr8MEW5E2BssedOppDe4nMhNtlOm
         290oJallKkxVysNzEus01pXISW76wmW4U+mRFEtk=
Date:   Tue, 5 Oct 2021 13:07:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Nechaev <petr.nechaev@cogentembedded.com>
Subject: Re: [PATCH v3] usb: gadget: storage: add support for media larger
 than 2T
Message-ID: <YVwyDsuIT9lZWi2v@kroah.com>
References: <YUnsSxUERYj/oXTO@kroah.com>
 <20210921145901.11952-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921145901.11952-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:59:02PM +0300, Nikita Yushchenko wrote:
> This adds support for READ_CAPACITY(16), READ(16) and WRITE(16)
> commands, and fixes READ_CAPACITY command to return 0xffffffff if
> media size does not fit in 32 bits.
> 
> This makes f_mass_storage to export a 16T disk array correctly.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
> v3:
> - added this changelog
> 
> v2:
> - fixed call to check_command() for READ_CAPACITY(16)
> - fixed alphabetical order of commands in switch statement
> - renamed variable, added comments, and fixed formatting, per advices by
>   Alan Stern <stern@rowland.harvard.edu>

Felipe and Alan, any objections to this change?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039353F0CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhHRUl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233153AbhHRUlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:41:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F849610FE;
        Wed, 18 Aug 2021 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629319249;
        bh=5tva/r9Oj0UN/sp05F4nzM/MGgwTGTX7IE9UMourYXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdcITPKrE0bBE3TiHA/Q3+5HDAfoqXbDQWtuid/rwPLd1IKqT+WWma5fdxulLtuJZ
         BM3LlBiCapRxMv2a01i2ll4V7JcuqC9KiK6ci4WTeigum3IyQdxQ0N+swNxxX06BgA
         obnZ9tDmC72NXvvcHvX6mvNg2rthYw7l5TthRoF8=
Date:   Wed, 18 Aug 2021 22:40:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] staging: r8188eu: clean up endianness issues
Message-ID: <YR1wT0cLoiuXsIEM@kroah.com>
References: <8a3fca82d9ec5dde9e42d40f0268a324cc87ebc6.1629301854.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a3fca82d9ec5dde9e42d40f0268a324cc87ebc6.1629301854.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 09:22:36PM +0530, Aakash Hemadri wrote:
> Fix these sparse warnings:
> 
> > rtw_br_ext.c:73:23: warning: restricted __be16 degrades to integer
> 
> Here tag->tag_len is be16, use ntohs()
> 
> > rtw_br_ext.c:601:57: warning: incorrect type in assignment (different base types)
> > rtw_br_ext.c:601:57:    expected unsigned short
> > rtw_br_ext.c:601:57:    got restricted __be16 [usertype]
> 
> > rtw_br_ext.c:664:45: warning: cast to restricted __be16
> > rtw_br_ext.c:771:84: warning: incorrect type in argument 3 (different base types)
> > rtw_br_ext.c:771:84:    expected unsigned int [usertype] len
> 
> Cast MAGIC_CODE as unsigned short
> 
> > rtw_br_ext.c:771:84:    got restricted __be16 [usertype] payload_len
> > rtw_br_ext.c:773:110: warning: incorrect type in argument 2 (different base types)
> > rtw_br_ext.c:773:110:    expected int len
> > rtw_br_ext.c:773:110:    got restricted __be16 [usertype] payload_len
> 
> > rtw_br_ext.c:836:54: warning: cast to restricted __be32
> 
> Unnecessary double cast?
> 
> > rtw_br_ext.c:839:70: warning: restricted __be16 degrades to integer
> > rtw_br_ext.c:845:70: warning: invalid assignment: |=
> > rtw_br_ext.c:845:70:    left side has type unsigned short
> > rtw_br_ext.c:845:70:    right side has type restricted __be16
> 
> dhcp->flag is u16

That is a lot of different things all at once.  Please break this up
into one-logical-change at a time and send a patch series.

thanks,

greg k-h

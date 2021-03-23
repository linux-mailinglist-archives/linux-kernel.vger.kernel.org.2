Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784A83468A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhCWTNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233072AbhCWTMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:12:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 514AC619B3;
        Tue, 23 Mar 2021 19:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616526773;
        bh=S0QuPCT0DzeEFf2Q94Zxu8BVMBFrKjxRW0STuenHCtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nN0AvQCLCA0A6Lf7zEkbiS9cvnidB1GRfft8tBDV1U9z6b+2sqQPeTXDuNmc+SnmW
         e3PsR93rOMEhmcQ993SRKy2vOP7zguZdwrVtM/PQyzenDALUCsOKhMmA7hw3tj9qrn
         Y+CtBrZyMHs2g1PVv8aMN7CCtQs/pl1I8GIVpyro=
Date:   Tue, 23 Mar 2021 20:12:51 +0100
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Don Bollinger <don@thebollingers.org>
Cc:     arndb@arndb.de, linux-kernel@vger.kernel.org,
        brandon_chuang@edge-core.com, wally_wang@accton.com,
        aken_liu@edge-core.com, gulv@microsoft.com, jolevequ@microsoft.com,
        xinxliu@microsoft.com
Subject: Re: [PATCH v2] eeprom/optoe: driver to read/write SFP/QSFP/CMIS
 EEPROMS
Message-ID: <YFo9s/Qyrfk4FG6z@kroah.com>
References: <20210215193821.3345-1-don@thebollingers.org>
 <YFn3ahkF4w/IClaw@kroah.com>
 <008d01d72014$7b113900$7133ab00$@thebollingers.org>
 <YFo6mZqOaY+2zApa@kroah.com>
 <009501d72017$eb30a790$c191f6b0$@thebollingers.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009501d72017$eb30a790$c191f6b0$@thebollingers.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:08:32PM -0700, Don Bollinger wrote:
> On Tue, Mar 23, 2021 at 12:00AM -0700, Greg KH wrote:
> > On Tue, Mar 23, 2021 at 11:43:55AM -0700, Don Bollinger wrote:
> > > On Tue, Mar 23, 2021 at 7:12AM-0700, Greg KH wrote:
> > > > On Mon, Feb 15, 2021 at 11:38:21AM -0800, Don Bollinger wrote:
> > > > > optoe is an i2c based driver that supports read/write access to
> > > > > all the pages (tables) of MSA standard SFP and similar devices
> > > > > (conforming to the SFF-8472 spec), MSA standard QSFP and similar
> > > > > devices (conforming to the SFF-8636 spec) and CMIS and similar
> > > > > devices (conforming to the Common Management Interface
> > Specfication).
> > > >
> > >
> > > I promise not to engage in a drawn out email exchange over this, but I
> > > would like to appeal your decision, just once...
> 
> Thanks for your response.  As promised, I'm done.
> 
> Is there a correct protocol for withdrawing a patch, or does it just get
> abandoned?  Still trying to be a good citizen.

Patches just get abandonded, nothing special to do here, we have mailing
lists littered with them :)

thanks,

greg k-h

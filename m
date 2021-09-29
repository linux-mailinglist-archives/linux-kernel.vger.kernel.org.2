Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2C841C7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbhI2PDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:03:33 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56157 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1344958AbhI2PDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:03:32 -0400
Received: (qmail 429498 invoked by uid 1000); 29 Sep 2021 11:01:51 -0400
Date:   Wed, 29 Sep 2021 11:01:51 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v2] usb: ohci: add check for start frame in host
 controller functional states
Message-ID: <20210929150151.GB428239@rowland.harvard.edu>
References: <1632910167-23554-1-git-send-email-zhuyinbo@loongson.cn>
 <20210929145905.GA428239@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929145905.GA428239@rowland.harvard.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:59:05AM -0400, Alan Stern wrote:
> On Wed, Sep 29, 2021 at 06:09:27PM +0800, Yinbo Zhu wrote:
> > The pm states of ohci controller include UsbOperational, UsbReset, UsbSuspend
> 
> Those aren't really PM states.  The specification calls them "USB 
> states".
> 
> > , and UsbResume. Among them, only the UsbOperational state supports launching
> --^
> 
> This comma should come directly after the word "launching", with no 

Sorry, I meant the word "UsbSuspend", not "launching".

Alan Stern

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF43F71AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhHYJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232774AbhHYJZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:25:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BC94610E9;
        Wed, 25 Aug 2021 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629883488;
        bh=Xk06BbM25q7nxyadva5lBrMQabJjtthqr6TzjMZcHRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QR7vzBQt5ofzBvDNNGSUx6xgic/6bf4JZE9mcvBV1/kWBsYkf4X+QnNYWVgySJKQ5
         FvucNTiMRGBoU6KpVuWrmHey2uLt52+FaXdaj8XEKn/gzUhq55jdqtzlQy6E/3q1b7
         O4r9wVg3c4T/tXxaC/sjlBnXha/+GDJ3mdP8mMdscxFVSUdVKJ3wcD46pL1l1WMw/j
         uvOwnNJu5GY8z6v08hNzjwrNOXB06NTvhnFNlHNRXkwP8bShZzV8CYXRaBFnJa+Nco
         Ydg94ImGXN980Y24N/JypVS7ytKeKdHlZVhrA7+BcLaDpXAiyKApgr+Q8sk1QSOqDI
         XbHiPJ0MfeHAA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mIp9I-00019n-Kc; Wed, 25 Aug 2021 11:24:44 +0200
Date:   Wed, 25 Aug 2021 11:24:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] USB: serial: iuu_phoenix: Replace symbolic permissions
 by octal permissions
Message-ID: <YSYMXNvfjk0HdYr3@hovoldconsulting.com>
References: <20210820190306.18149-1-utkarshverma294@gmail.com>
 <YST6XZ/XJkTDm6rV@hovoldconsulting.com>
 <20210824191537.GA6181@uver-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824191537.GA6181@uver-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:45:37AM +0530, Utkarsh Verma wrote:
> On Tue, Aug 24, 2021 at 03:55:41PM +0200, Johan Hovold wrote:
> > On Sat, Aug 21, 2021 at 12:33:06AM +0530, Utkarsh Verma wrote:
> > > This fixed the below checkpatch issue:
> > > WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred.
> > > Consider using octal permissions '0644'.
> > 
> > Please do not run checkpatch.pl on code that's already in the tree. Use
> > it for your own patches before submitting them and always use your own
> > judgement when considering its suggestions.
> > 
> 
> Okay, I will not run checkpatch on the code that's already in the tree.
> 
> > This code does not need to be changed.
> 
> But using the octal permission bits makes the code more readable. So I
> made the change.

Then put that in the commit message since that may be a valid motivation
for the change (unlike shutting up checkpatch.pl).

But if you want to do this then do it subsystem wide in one patch rather
than change only one of the seven usb-serial drivers that use the
permission macros.

Johan

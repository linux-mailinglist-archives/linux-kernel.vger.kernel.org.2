Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5535ACBA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhDJKcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 06:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234091AbhDJKcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 06:32:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F2AE610E5;
        Sat, 10 Apr 2021 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618050727;
        bh=ADmiV9I77wzT2I1XBSip0xU3FgQtVLa5Di2DzT5VLD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcysymlKeAJtnv1ymoiiHOaMSISEK5BUham88EuM+oT9e/jX0jWG1a6GM+6/Yn2t6
         tla+NGER//MLHDBUIB3qRm1c5ykJ/CjXCtqdqUpD3qaLEiDeuXl3RGlQRUlGmhChwk
         j3+qscQpp4XLVCSyzlOKsiinhDiRCGV+ezDFT8wg=
Date:   Sat, 10 Apr 2021 12:32:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v7 1/3] staging: rtl8723bs: Remove
 camelcase in several files
Message-ID: <YHF+pQ7cWDbXvNWT@kroah.com>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com>
 <20210410092232.15155-2-fmdefrancesco@gmail.com>
 <YHFwkJlTNxQwPyN3@kroah.com>
 <3026831.3QyE5GyAct@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3026831.3QyE5GyAct@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:45:18AM +0200, Fabio M. De Francesco wrote:
> On Saturday, April 10, 2021 11:32:00 AM CEST Greg KH wrote:
> > On Sat, Apr 10, 2021 at 11:22:29AM +0200, Fabio M. De Francesco wrote:
> > > Remove camelcase in bFwCurrentInPSMode, a variable used by code
> > > of several subdirectories/files of the driver. Issue detected by
> > > checkpatch.pl. Delete the unnecessary "b" (that stands for "byte") from
> > > the beginning of the name.
> > > 
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > 
> > Why is there a "v7" in this subject line, but not all the other lines?
> > 
> 
> It's v7 because only this file (and not the others in the series had six 
> previous versions that you dropped. Please remind that it was already sent 
> alone (not in a series) several times. The changelog is in the body.
> 
> Should I drop that "v7" and the changelog, and the send the patch series 
> anew?

It's a v2 series now, right?  :)

> Please, I'm waiting your instructions on what to do.

Don't "wait" for anyone, least of all me.  Do what you think is needed,
after waiting a bit of time, there's no rush here...

thanks,

greg k-h

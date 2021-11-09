Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD0444B091
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhKIPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237909AbhKIPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:44:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A950E61104;
        Tue,  9 Nov 2021 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636472508;
        bh=1q6IxLmpJQu5s3uGGnQFQ9Si2OQ11miAmiOnpfKCVBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihLb0JiYiMpf9TX/qrIWN41/bXa2qJ9cU/JhR0YkTPktUhdd9LSrtExiizn1ii/9a
         ZNvpKC/LUC2k7rEHGsIT0It8XOz5QGFqnukYQzsJ99vJ8D9YgfdrUSY4cQWp1P3vX2
         IeQhSy9CXH52phHRIHVEnHuWstIN9nN6jF8zYGK4=
Date:   Tue, 9 Nov 2021 16:41:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: ppdev: fixed a validation issue
Message-ID: <YYqWuYK/c6D9K3Xi@kroah.com>
References: <20211108185818.GA73382@makvihas>
 <YYoUYOyyP4EFYTSJ@kroah.com>
 <CAH1kMwSqfNT-jB70c6Md_Wa6Sn6GJKr2=LOunSaZwEk2TKzraA@mail.gmail.com>
 <YYpaP1fAg7jrFyhJ@kroah.com>
 <CAH1kMwR7BA6kpcHCmEnEQ_EPeJxFDHQ3QB9mAn0D8NzdB8LNhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1kMwR7BA6kpcHCmEnEQ_EPeJxFDHQ3QB9mAn0D8NzdB8LNhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:04:57PM +0530, Vihas Mak wrote:
> > What happens today if the mode is not set properly?  Will the code paths
> > error out eventually, or will the call succeed?  The problem is that
> > there might be code that is working today that would break with a change
> > like this, as again, this is a very old driver.
> 
> I see. So I guess this driver might be better off without any changes,
> as new changes might break things more severely.

Changes in behavior always have the ability to break things.  What other
changes do you want to make to this old driver that might cause
problems?

And you didn't answer my question above, what happens if the mode is not
set properly today?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B16331F773
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBSKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhBSKkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:40:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E3BE64E43;
        Fri, 19 Feb 2021 10:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613731170;
        bh=urp5ZOcocqWHVmfIWn6PjXFv/C9rB6YTIaWKOtHWh4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISp7o3lKsD1idpqx3DrPqcrG2YYXsowcS4Umi/rJJRJxedH6Bol6628CRrKZwkSIC
         jLvOOvgYPLv46ipwJT7D3vlI6VAaz7PmpR5j+d1fGNuWSti9tP6wDzBLGS9PW7xZxS
         fFjq3eaaCknamwPx7G55oIqoOQUmaOkDbLtW5BoE=
Date:   Fri, 19 Feb 2021 11:39:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     17UCS047_Prakash Dubey <prakashdubey1999@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fwserial: Fix alignment of function parameters
Message-ID: <YC+VX4NpOWX1z3+V@kroah.com>
References: <20210218102851.GA20810@gmail.com>
 <YC9zNVWX7R9kD0Rq@kroah.com>
 <CALVjNJP=iXH+u2zUB93UZo+1+Ly0g23k5JtPXFbx=vaO+5-0Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVjNJP=iXH+u2zUB93UZo+1+Ly0g23k5JtPXFbx=vaO+5-0Gw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:25:38PM +0530, 17UCS047_Prakash Dubey wrote:
> I was unable to align it right below the opening parenthesis, just by using
> tabs. And when I did that with spaces, the checkpatch yelled at me for
> using spaces. Any suggestions how to do this without using spaces? I am
> using vim, I will try to find a workaround meanwhile.

I have no context here for what you are asking about at all, sorry.

greg k-h

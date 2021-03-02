Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC732A689
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574387AbhCBPPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347949AbhCBMzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:55:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E715B61494;
        Tue,  2 Mar 2021 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614689640;
        bh=73peVIMVRScHS0BOCRlqEB4HOD3Y8aQplI5JLB1L6Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=15KSP9ZRvrpTsCaDapZ2GjURJFqyIF6tEpP1jfcHoDuRYgvF3K3hlcepiCOf/oHhc
         Ap+nSvO/f4CGtcwkToXwU58QqAh2yKOpUaXIgh7Iz7dn2KlkNVMTVJ2VFnt6IZMxu/
         6l5VEt/WA7T+OV/UGgbVIypV0R8krc7VrVyqLrvU=
Date:   Tue, 2 Mar 2021 13:53:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vikas Kumar Sharma <ks.vikas@globaledgesoft.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] This patch fixes the check-patch errors
Message-ID: <YD41ZR5tuXJsWfMo@kroah.com>
References: <20210302124254.GA2349431@vijayakumar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302124254.GA2349431@vijayakumar>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 06:12:54PM +0530, Vikas Kumar Sharma wrote:
> Disclaimer:This message is intended only for the designated recipient(s). 
> It may contain confidential or proprietary information and may be subject 
> to other confidentiality protections. If you are not a designated 
> recipient, you may not review, copy or distribute this message. Please 
> notify the sender by e-mail and delete this message. GlobalEdge does not 
> accept any liability for virus infected mails.

Email is now deleted, sorry, this does not belong on any emails sent to
public mailing lists for kernel development efforts.


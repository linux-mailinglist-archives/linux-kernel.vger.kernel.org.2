Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9779C30D5F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhBCJLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhBCJIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:08:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D37E664F7C;
        Wed,  3 Feb 2021 09:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612343270;
        bh=jSiB2eh7z20wSqXsrq7i3ztg06W8skYeSe5faR9mkQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDTzMYVB9PSwUe1cB3XZhfs6cjTIOUyzbcJcrExHbrUuDDU1UEs9Eii/UDV1/jT3q
         paf13rFn0vIPL7c8QXyivyEU3taUsQCeRJ8eB0JVj0jOs4ooXF2SPa6REhpmSwI2rK
         rpzYLculsPqRPf/IOyS2b9XzpCJLCdz9ygYYAJMI=
Date:   Wed, 3 Feb 2021 10:07:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: generic-ohci: Add missing
 compatible strings
Message-ID: <YBpn4zqGk6mV0aII@kroah.com>
References: <20210202175439.3904060-1-robh@kernel.org>
 <20210202175439.3904060-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202175439.3904060-2-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 11:54:39AM -0600, Rob Herring wrote:
> The generic OHCI binding needs to document all the specific compatible
> strings so we can track undocumented compatible strings. Add all the
> compatible strings from in tree users.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/usb/generic-ohci.yaml | 34 +++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)

Both look fine to me, do you want me to take this through my trees or
will you take them?

If you want to, fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If not, just let me know and I will pick them up.

thanks,

greg k-h

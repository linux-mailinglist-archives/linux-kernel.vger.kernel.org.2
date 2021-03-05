Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6CA32F3E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhCETac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:30:32 -0500
Received: from netrider.rowland.org ([192.131.102.5]:49113 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229616AbhCETaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:30:04 -0500
Received: (qmail 49912 invoked by uid 1000); 5 Mar 2021 14:30:03 -0500
Date:   Fri, 5 Mar 2021 14:30:03 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using
 xhci_hcd
Message-ID: <20210305193003.GE48113@rowland.harvard.edu>
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
 <20210301155321.GA1490228@rowland.harvard.edu>
 <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu>
 <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 08:22:22PM +0100, Sedat Dilek wrote:
> The quirks match:
> 
> [Fri Mar  5 20:06:56 2021] usb-storage 4-1:1.0: USB Mass Storage device detected
> [Fri Mar  5 20:06:56 2021] usb-storage 4-1:1.0: Quirks match for vid
> 174c pid 55aa: 400000
> 
> That seems not to be the trick:
> 
> root# LC_ALL=C dmesg -T | grep 'usb 4-1:'
> [Fri Mar  5 20:06:55 2021] usb 4-1: new SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar  5 20:06:55 2021] usb 4-1: New USB device found,
> idVendor=174c, idProduct=55aa, bcdDevice= 1.00
> [Fri Mar  5 20:06:55 2021] usb 4-1: New USB device strings: Mfr=2,
> Product=3, SerialNumber=1
> [Fri Mar  5 20:06:55 2021] usb 4-1: Product: MEDION HDDrive-n-GO
> [Fri Mar  5 20:06:55 2021] usb 4-1: Manufacturer: MEDION
> [Fri Mar  5 20:06:55 2021] usb 4-1: SerialNumber: 3180000000000000092C
> [Fri Mar  5 20:06:57 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd

Okay, that indicates the ATA commands are being sent not by the kernel 
but by some program.  I'm not sure how you can easily find out which 
program; probably the best thing to do is turn them off one by one until 
you find the one responsible.

Alan Stern

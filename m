Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9BC34B9C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 23:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhC0WSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 18:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhC0WSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 18:18:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CEDC0613B1;
        Sat, 27 Mar 2021 15:18:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w8so4227549pjf.4;
        Sat, 27 Mar 2021 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TfAEx42ev3o6ArqZhaNIyJVqiP9OCV2R4A7TGL7rtCQ=;
        b=hEIX0oPfFAcrO/k2kHkBhcRtyqj0FD8mWIVQTlxw0OI+uaj1TI1YX6ADQim1U0iOZW
         GuL0cAthlpIezO6y+IRAKjh6xXQTNQKBxgHSTmG4tnmf78nGsxPtZ3dC2UDFWBAt3eEG
         rl0eyQgCNjLI9L76/2PPYxRLs9DJkSmB4HB1bjINsGI/kKTUm/NrrypRdfdN7BFwYzF+
         jewrygWiUtD/GptSIm9w+FsGIsNA3FMxcua0D1JMHJU+va2wrmTH6l2P8YsydoAkAgmE
         q4NTr0kcCPcJVnRsSNN+hrlpRL8/QluboOjTnotPEFTSygMmBHUZyPvikhMck07XnRuU
         doug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TfAEx42ev3o6ArqZhaNIyJVqiP9OCV2R4A7TGL7rtCQ=;
        b=aqJI+dSAePfxGXKR3YsMtJ0lM/bpDPRgUrl7CSd8HaA71T6jR5v4o4sFJ/NeWVqAi6
         ADdDEejgCAUbe9R+TvVkanPk5idFlY/MNUSMj1nVG6gTu1YiMfXFM/Yz+VzySDivwNeP
         gk9A0XQlj8+N02cv9O1lVdCQ3qO2KBA9Xdtl9l0QQUOIoBw0aXaurYu2FXCRftEeBCKh
         2qpSahq4hLZykgZTMgJMnOc9CUgz340URttFDaIftMT5Q9CXsTRKQMKlhvoYx8jYF9v4
         PtXLSK25QFANEOeHTNrlR2E80EP8JxeLJ1WHa01Lg55HLff/VL3N+KNdQf4KmAGM6OWM
         tv3w==
X-Gm-Message-State: AOAM530BqUbIxQzX5Yi3L87/3XDgZoVL+gb0b87kPgCVtk8I5wyXXDg8
        iVfozL4Fbw5kxq4guqci7DE=
X-Google-Smtp-Source: ABdhPJzeFGmdx4jE/ciUSpsHKE6xAr8FYqvdR4DTlTaf3eq386gCWxZiN00dRBITxd0uK38fOjOKcQ==
X-Received: by 2002:a17:902:ce8d:b029:e4:bc38:c4 with SMTP id f13-20020a170902ce8db02900e4bc3800c4mr21203549plg.48.1616883487619;
        Sat, 27 Mar 2021 15:18:07 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b10sm12555994pgm.76.2021.03.27.15.18.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Mar 2021 15:18:07 -0700 (PDT)
Date:   Sat, 27 Mar 2021 15:17:59 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tao Ren <taoren@fb.com>
Subject: Re: [PATCH] usb: gadget: aspeed: set port_dev dma mask
Message-ID: <20210327221759.GA2997@taoren-ubuntu-R90MNF91>
References: <20210326070214.6719-1-rentao.bupt@gmail.com>
 <10920f34-289c-feac-79b6-71bff2aea67d@arm.com>
 <20210326120526.GA14169@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326120526.GA14169@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 01:05:26PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 26, 2021 at 12:03:03PM +0000, Robin Murphy wrote:
> > This might happen to work out, but is far from correct. Just wait until you 
> > try it on a platform where the USB controller is behind an IOMMU...
> >
> > It looks like something is more fundamentally wrong here - the device 
> > passed to DMA API calls must be the actual hardware device performing the 
> > DMA, which in USB-land I believe means the controller's sysdev.
> 
> The shiny new usb_intf_get_dma_device API provides the device to use.

Thanks Robin and Christoph for the feedback.

If I understand correctly, usb_intf_get_dma_device API is mainly for usb
host drivers? I just found usb_gadget_map_request_by_dev API: does it
make sense to replace usb_gadget_map_request with
usb_gadget_map_request_by_dev so we can pass the actual DMA-capable
hardware device (aspeed-vhub platform device) to the API?


Cheers,

Tao

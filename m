Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084123369EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhCKByp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:54:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:21313 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCKByY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:54:24 -0500
IronPort-SDR: n4QscP5TaPk6PDPiLclQ8OPrSb56Ed6y7k/oFPIWhQabPmd/OsmxBP3RxGF57+brkSrUUa/VP0
 2smwvaU2qVHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186219452"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="186219452"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 17:54:24 -0800
IronPort-SDR: 6yaVsVzHqr8Dity8VwVeMdgzpungJTYbydUHlfbiYUbVuAbUwD9c4ie1Z1PPBRCXgU1PDYFRK8
 86EYWLc2K8BQ==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="403909316"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 17:54:23 -0800
Date:   Thu, 11 Mar 2021 09:54:21 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virt: acrn: Fix document of acrn_msi_inject()
Message-ID: <20210311015421.GB28452@shuo-intel.sh.intel.com>
References: <20210310160538.26227-1-shuo.a.liu@intel.com>
 <YEkBme4o4Q9URaJe@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YEkBme4o4Q9URaJe@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10.Mar'21 at 18:27:53 +0100, Greg Kroah-Hartman wrote:
>On Thu, Mar 11, 2021 at 12:05:38AM +0800, Shuo Liu wrote:
>> This fixes below build warning.
>>
>> ../drivers/virt/acrn/vm.c:105: warning: expecting prototype for
>> acrn_inject_msi(). Prototype was for acrn_msi_inject() instead
>
>That's not a "normal" build warning is it?  the compiler isn't spitting
>it out...
>
>Sorry to be a pain, but please be specific as to what is causing this to
>show up...

Sure. V3 is sent out.

Thanks
shuo

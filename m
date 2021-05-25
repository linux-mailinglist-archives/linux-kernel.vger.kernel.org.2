Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760E738FC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhEYH7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:59:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:39251 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhEYH72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:59:28 -0400
IronPort-SDR: 0WVyNm3USEH7qYjViZaDn+GC+rOhymMUCu1P2qd4wgqFuZCD3VrlTD9E4c/jc+Z0/pI6w9qgE7
 9tKWpTiFEpAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="200231377"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="200231377"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 00:50:38 -0700
IronPort-SDR: /3bdNeeimRPEbziclmisq8qcBIllCPKbDomBj5N4NNSaf9+EHktBiVIm7Id6/gvtL4P00r8E3k
 YJQxU/9Hdwmw==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="442432356"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 00:50:35 -0700
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com> <20210513110040.2268-12-maciej.kwapulinski@linux.intel.com> <YJ0MXK2XSISC1fIl@kroah.com> <85o8ddiv51.fsf@linux.intel.com> <YJ41h6lt8lSqaH7r@kroah.com> <85h7isif8y.fsf@linux.intel.com> <YKuEsD9UMlSz3+HA@kroah.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v3 11/14] intel_gna: add ioctl handler
In-reply-to: <YKuEsD9UMlSz3+HA@kroah.com>
Date:   Tue, 25 May 2021 09:50:32 +0200
Message-ID: <85cztfi75j.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Mon, May 24, 2021 at 12:43:25PM +0200, Maciej Kwapulinski wrote:
>> 
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Fri, May 14, 2021 at 10:20:42AM +0200, Maciej Kwapulinski wrote:
>> >> 
>> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> >> 
>> >> > On Thu, May 13, 2021 at 01:00:37PM +0200, Maciej Kwapulinski wrote:
>> >> >> From: Tomasz Jankowski <tomasz1.jankowski@intel.com>
>> >> >> 
>> >> >> Add ioctl handler into GNA driver.
>> >> >> The ioctl interface provides the ability to do the following:
>> >> >>  - Map and unmap memory buffers for GNA computation requests.
>> >> >>  - Retrieve capabilities of the underlying GNA IP.
>> >> >>  - Submit GNA computation requests.
>> >> >>  - Request notification of scoring completion.
>> >> >
>> >> > Do you have a pointer to the userspace code that uses this ioctl?
>> >> > That's kind of required here, otherwise we have no idea how this all
>> >> > works.
>> >> >
>> >> 
>> >> yes, it's present under following link:
>> >> 
>> >> https://github.com/intel/gna
>> >
>> > Then that needs to go here in this changelog text, right?
>> 
>> link to library is already present in 00/14, I didn't want to have it in
>> two places, that's why not present here.
>
> Commit 00/XX never shows up in the changelog :(

right

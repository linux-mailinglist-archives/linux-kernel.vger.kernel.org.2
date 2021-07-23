Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470D53D3A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhGWMI2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jul 2021 08:08:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:4024 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhGWMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:08:24 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4GWTZV3wcBzmjPd;
        Fri, 23 Jul 2021 20:45:54 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 20:48:55 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 23 Jul 2021 20:48:55 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Valentin Schneider" <valentin.schneider@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
 of sysfs pagebuf
Thread-Topic: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
 of sysfs pagebuf
Thread-Index: AQHXPMXH0SQBD1qG+ECo3ZrOidSRtqrLBimAgADzHOD//4cYAIAAjhuw//+CrICAhVoEQP//gPKAABN7liA=
Date:   Fri, 23 Jul 2021 12:48:55 +0000
Message-ID: <552730f6c9d046e4bc313abce5714c59@hisilicon.com>
References: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
 <1619679819-45256-2-git-send-email-tiantao6@hisilicon.com>
 <146e051b-603c-a6d3-43d8-d083cf2c8119@intel.com>
 <602918a1e2214ea7bd0890a751975566@hisilicon.com>
 <7c663f7e-07e0-6d95-3012-6e31a1b78f7e@intel.com>
 <4bf6870f7f3942398e4d1fdaa42184c7@hisilicon.com>
 <fd78ac30-dd3b-a7d7-eae8-193b09a7d49a@intel.com>
 <e9610060a8d046e783ab9a229f35410c@hisilicon.com> <YPqn5SDi6bzLHsOY@kroah.com>
In-Reply-To: <YPqn5SDi6bzLHsOY@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: gregkh@linuxfoundation.org [mailto:gregkh@linuxfoundation.org]
> Sent: Friday, July 23, 2021 11:29 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Dave Hansen <dave.hansen@intel.com>; tiantao (H) <tiantao6@hisilicon.com>;
> corbet@lwn.net; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> Rafael J. Wysocki <rafael@kernel.org>; Peter Zijlstra <peterz@infradead.org>;
> Valentin Schneider <valentin.schneider@arm.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; Daniel Bristot de Oliveira
> <bristot@redhat.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
> of sysfs pagebuf
> 
> On Fri, Jul 23, 2021 at 11:20:19AM +0000, Song Bao Hua (Barry Song) wrote:
> >
> >
> > > -----Original Message-----
> > > From: Dave Hansen [mailto:dave.hansen@intel.com]
> > > Sent: Friday, April 30, 2021 10:39 AM
> > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; tiantao (H)
> > > <tiantao6@hisilicon.com>; corbet@lwn.net; gregkh@linuxfoundation.org
> > > Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Rafael J.
> > > Wysocki <rafael@kernel.org>; Peter Zijlstra <peterz@infradead.org>;
> Valentin
> > > Schneider <valentin.schneider@arm.com>; Dave Hansen
> > > <dave.hansen@linux.intel.com>; Daniel Bristot de Oliveira
> <bristot@redhat.com>
> > > Subject: Re: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
> > > of sysfs pagebuf
> > >
> > > On 4/29/21 3:32 PM, Song Bao Hua (Barry Song) wrote:
> > > > $ strace numactl --hardware  2>&1 | grep cpu
> > > > openat(AT_FDCWD, "/sys/devices/system/cpu",
> > > > O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
> > > > openat(AT_FDCWD, "/sys/devices/system/node/node0/cpumap", O_RDONLY) =
> 3
> > > > openat(AT_FDCWD, "/sys/devices/system/node/node1/cpumap", O_RDONLY) =
> 3
> > > > openat(AT_FDCWD, "/sys/devices/system/node/node2/cpumap", O_RDONLY) =
> 3
> > > > openat(AT_FDCWD, "/sys/devices/system/node/node3/cpumap", O_RDONLY) =
> 3
> > > >
> > > > If we move to binary, it means we have to change those applications.
> > >
> > > I thought Greg was saying to using a sysfs binary attribute using
> > > something like like sysfs_create_bin_file().  Those don't have the
> > > PAGE_SIZE limitation.  But, there's also nothing to keep us from spewing
> > > nice human-readable text via the "binary" file.
> > >
> > > We don't need to change the file format, just the internal kernel API
> > > that we produce the files with.
> >
> > Sorry for waking-up the old thread.
> >
> > I am not sure how common a regular device_attribute will be larger than
> > 4KB and have to work around by bin_attribute. But I wrote a prototype
> > which can initially support large regular sysfs entry and be able to
> > fill the entire buffer by only one show() entry. The other words to say,
> > we don't need to call read() of bin_attribute multiple times for a large
> > regular file. Right now, only read-only attribute is supported.
> >
> > Subject: [RFC PATCH] sysfs: support regular device attr which can be larger
> than
> >  PAGE_SIZE
> >
> > A regular sysfs ABI could be more than 4KB, right now, we are using
> > bin_attribute to workaround and break this limit. A better solution
> > would be supporting long device attribute. In this case, we will
> > still be able to enjoy the advantages of buffering and seeking of
> > seq file and only need to fill the entire buffer of sysfs entry
> > once.
> 
> No, please no.  I WANT people to run into this problem and realize that
> it went totally wrong because they should not be having more than one
> "value" in a sysfs file like this.
> 
> Let's not make it easy on people please, moving to a bin attribute is a
> big deal, let's keep it that way.

Ok. Got it. Thanks for clarification. That was the experiment I made
recently when I almost got totally stuck.

> 
> thanks,
> 
> greg k-h

Thanks
Barry

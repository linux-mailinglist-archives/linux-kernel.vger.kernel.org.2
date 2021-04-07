Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A394635730D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354845AbhDGRXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:23:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:44718 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354793AbhDGRW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:22:56 -0400
IronPort-SDR: NvYdEg7dBCcx2y7w/UeX8UUFtbIW3h2I0w/n0cm4RP9TDI4V5uPElchIwyoNIRPs7FiXKgk/zM
 2bOIbvlXFh4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193402814"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="193402814"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:22:46 -0700
IronPort-SDR: KwRl/Bnk4CW00c6/1V3Y0pBj3HWwW469ITP0J+7ckACoT5J/yen/fYNsRM+UpncpcDyIEyF8sr
 7soW871bFdKw==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="519516437"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:22:43 -0700
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com> <20210324183610.4574-2-maciej.kwapulinski@linux.intel.com> <CAHp75Vf54GNsw_xWqiOhZx5aHHnQ_-wUWugQ8w9vJPRheLxHFA@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v2 01/13] intel_gna: add driver module
In-reply-to: <CAHp75Vf54GNsw_xWqiOhZx5aHHnQ_-wUWugQ8w9vJPRheLxHFA@mail.gmail.com>
Date:   Wed, 07 Apr 2021 19:22:40 +0200
Message-ID: <85sg42nh5r.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Wed, Mar 24, 2021 at 8:38 PM Maciej Kwapulinski
> <maciej.kwapulinski@linux.intel.com> wrote:
>>
....
>> diff --git a/include/uapi/misc/intel/gna.h b/include/uapi/misc/intel/gna.h
>> new file mode 100644
>> index 000000000000..a7e435b74a0a
>> --- /dev/null
>> +++ b/include/uapi/misc/intel/gna.h
>> @@ -0,0 +1,155 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>> +/* Copyright(c) 2017-2021 Intel Corporation */
>> +
>> +#ifndef _UAPI_GNA_H_
>> +#define _UAPI_GNA_H_
>> +
>> +#if defined(__cplusplus)
>> +extern "C" {
>> +#endif
>
>> +#include <linux/types.h>
>> +#include <linux/ioctl.h>
>> +#include <linux/const.h>
>
> Ordered?
>
What do You mean?

>>
......
>> +struct gna_compute_cfg {
>> +       __u32 layer_base;
>> +       __u32 layer_count;
>> +
>> +       /* List of GNA memory buffers */
>> +       __u64 buffers_ptr;
>> +       __u64 buffer_count;
>> +
>> +       __u8 active_list_on;
>> +       __u8 gna_mode;
>> +       __u8 hw_perf_encoding;
>> +       __u8 pad[5];
>> +};
>> +
>> +union gna_parameter {
>> +       struct {
>> +               __u64 id;
>> +       } in;
>> +
>> +       struct {
>> +               __u64 value;
>> +       } out;
>> +};
>> +
>> +union gna_memory_map {
>> +       struct {
>> +               __u64 address;
>> +               __u32 size;
>> +               __u32 pad;
>> +       } in;
>> +
>> +       struct {
>> +               __u64 memory_id;
>> +       } out;
>> +};
>> +
>> +union gna_compute {
>> +       struct {
>> +               struct gna_compute_cfg config;
>> +       } in;
>> +
>> +       struct {
>> +               __u64 request_id;
>> +       } out;
>> +};
>> +
>> +union gna_wait {
>> +       struct {
>> +               __u64 request_id;
>> +               __u32 timeout;
>> +               __u32 pad;
>> +       } in;
>> +
>> +       struct {
>> +               __u32 hw_status;
>> +               __u32 pad;
>> +               struct gna_drv_perf drv_perf;
>> +               struct gna_hw_perf hw_perf;
>> +       } out;
>> +};
>
> For all unions:
> How do you know which branch is used (out, in)? What field and where
> in the ABI points to that?

each of the unions above plays the role of in/out argument to its
corresponding ioctl call.

'in' part is used when ioctl() is called by client (userland
application) - data is written by app.

'out' part is read by app on exit from ioctl(), but only when ioctl()
retuns 0.

do You suggest adding the comment to gna.h for the above?

> .....

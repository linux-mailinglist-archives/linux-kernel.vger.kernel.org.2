Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5BB30C6D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhBBRCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:02:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:46686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237069AbhBBQ7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:59:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F28FAF1B;
        Tue,  2 Feb 2021 16:58:26 +0000 (UTC)
References: <20200615074723.12163-1-rpalethorpe@suse.com>
 <CAPcyv4jzfnnOTJTK5WKYpt_qOm1UWv-PZ7ZH3GiXf7x_oz6jQw@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coly Li <colyli@suse.com>
Subject: Re: [PATCH v2] nvdimm: Avoid race between probe and reading device
 attributes
Reply-To: rpalethorpe@suse.de
In-reply-to: <CAPcyv4jzfnnOTJTK5WKYpt_qOm1UWv-PZ7ZH3GiXf7x_oz6jQw@mail.gmail.com>
Date:   Tue, 02 Feb 2021 16:58:25 +0000
Message-ID: <87im7acspa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

Dan Williams <dan.j.williams@intel.com> writes:
>
> I see why this works, but I think the bug is in
> available_slots_show(). It is a bug for a sysfs attribute to reference
> driver-data without synchronizing against bind. So it should be
> possible for probe set that pointer whenever it wants. In other words
> this fix (forgive the whitespace damage from pasting).

Ah, that makes sense! I see the new patch and all is good AFAICT.

-- 
Thank you,
Richard.

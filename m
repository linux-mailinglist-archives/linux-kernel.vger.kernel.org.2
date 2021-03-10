Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD70333676
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhCJHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:37:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:45001 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCJHg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:36:57 -0500
IronPort-SDR: oeJClIGehzJZjC4HTOVHcMK70CzZqipJe0tavN+Um1F93jbmU1s0RTqE8vYzYmCjnbqbduLD14
 +7S/fffCwAbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249776572"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="249776572"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 23:36:56 -0800
IronPort-SDR: UAkbMdbJldkxjM5d2poW7X9YUErN6BXBA4WsjppwYuiQJ25zZhYaK1x+iFQ0A38icXJKshkYbH
 MZ9k9hiPpX8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509577418"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Mar 2021 23:36:53 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 10 Mar 2021 09:36:52 +0200
Date:   Wed, 10 Mar 2021 09:36:52 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] software node: Two fixes
Message-ID: <YEh3FGTExpE3IGhb@kuha.fi.intel.com>
References: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
 <YEdTGsr6CjUirOsn@smile.fi.intel.com>
 <CAJZ5v0ivHnHNTFPXKSgiKYY0fKiqSWuBaLh6noqE3xQEFC2-pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ivHnHNTFPXKSgiKYY0fKiqSWuBaLh6noqE3xQEFC2-pA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 02:51:22PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 9, 2021 at 11:51 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Mar 01, 2021 at 05:30:10PM +0300, Heikki Krogerus wrote:
> > > Hi,
> > >
> > > The second one only affects 5.12-rc1.
> >
> > Rafael, Greg, can this be applied for v5.12-rcX?
> 
> Do you have a pointer to this?

Pointer?

thanks,

-- 
heikki

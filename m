Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68A4341408
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhCSEMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:12:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:46764 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhCSEMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:12:33 -0400
IronPort-SDR: F6l1nLz741Z3AEC1YyfcDsdEe+2RkOfPJQp04RX6HUeLHX0t7d41LU2VfAVsZyVNgeCNAq6Mlj
 cn59ikpsKSSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189914065"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="189914065"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 21:12:33 -0700
IronPort-SDR: DbxeYJWDo8PaIc0g5bSFRA2ISTE+Ee2UrlNJRpC9K0qH6ddKmbgnd4tf7jT/XOubLFQ2Rj1asl
 EV6CjELPFhjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="591725210"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2021 21:12:32 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DC04B3023AF; Thu, 18 Mar 2021 21:12:32 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/18] dynamic debug diet plan
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
Date:   Thu, 18 Mar 2021 21:12:32 -0700
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com> (Jim Cromie's
        message of "Mon, 15 Mar 2021 23:07:43 -0600")
Message-ID: <87ft0rvl1r.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie <jim.cromie@gmail.com> writes:

> CONFIG_DYNAMIC_DEBUG creates a struct _ddebug (56 bytes) for each
> callsite, which includes 3 pointers to: module, filename, function.
> These are repetetive, and compressible, this patch series goes about
> doing that, it:

So how much memory does it actually save?
-Andi

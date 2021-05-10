Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6597C379221
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhEJPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:10:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:26711 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231594AbhEJPKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:10:10 -0400
IronPort-SDR: xD8ccfWjqJfO2E7Nrp3kUZyAhHnloaxIGi3XZtXkaXxjORgCfMUPT2fXx7sAvLxDPEG39GzpZ1
 g+GuFSN7MY5g==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="220163372"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="220163372"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 08:08:02 -0700
IronPort-SDR: /4uOdkZCIJEw6gztCue9p+MQP1uYplMGRHjRjr6uRojfyAyFocOtAV4zmSmJ1VJ8DJTUf3wv6d
 umAY7kwUsIGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="609133493"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2021 08:08:00 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2] STM: <linux/stm.h>: drop a duplicated word
In-Reply-To: <20210508064358.20335-1-rdunlap@infradead.org>
References: <20210508064358.20335-1-rdunlap@infradead.org>
Date:   Mon, 10 May 2021 18:07:59 +0300
Message-ID: <87wns6k4og.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Drop the repeated word "the" in a comment.

Picked up, thanks!

Regards,
--
Alex

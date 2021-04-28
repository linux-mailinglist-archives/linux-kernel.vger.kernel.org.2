Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC936D319
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhD1H2C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Apr 2021 03:28:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:3835 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1H2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:28:01 -0400
IronPort-SDR: 3HMg0k9GQAN+STnxMLFwgeLQ0muRnJ0qhHZaZArrfp1E3la9EC88NI0sKcNeEbvVp+hyz2uknn
 6Al2B9g7cLxQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="257981049"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="257981049"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 00:27:14 -0700
IronPort-SDR: tR9xIFfrlHKMLSXo4QTPjbAn1aIp7Ors5wVZq1YqZAbml0aQMrY2sHxI/fXWWVPGNsgzaFCTCS
 mocmMIogr7Kw==
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="430170642"
Received: from ajalsove-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.39.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 00:27:10 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: New warnings with gcc-11
In-Reply-To: <CAHk-=whOOVBBuQceJ9D9uZrv-QOUWGMQ4aZe2K+2X24o7xA8cg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAPM=9tyKdGHyiRLDooKrMf=02GtNn8U4YfF4dJtXdabnVAGdXQ@mail.gmail.com> <CAHk-=whOOVBBuQceJ9D9uZrv-QOUWGMQ4aZe2K+2X24o7xA8cg@mail.gmail.com>
Date:   Wed, 28 Apr 2021 10:27:07 +0300
Message-ID: <87bl9y50ok.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> I've updated to Fedora 34 on one of my machines, and it causes a lot
> of i915 warnings like
>
>   drivers/gpu/drm/i915/intel_pm.c: In function ‘ilk_setup_wm_latency’:
>   drivers/gpu/drm/i915/intel_pm.c:3059:9: note: referencing argument 3
> of type ‘const u16 *’ {aka ‘const short unsigned int *’}
>   drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
> ‘intel_print_wm_latency’
>
> and the reason is that gcc now seems to look at the argument array
> size more, and notices that

Arnd Bergmann reported some of these a while back. I think we have some
of them fixed in our -next already, but not all. Thanks for the
reminder.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center

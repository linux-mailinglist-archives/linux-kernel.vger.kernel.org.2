Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD33A46B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhFKQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:56277 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhFKQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:43:54 -0400
IronPort-SDR: pIEo9KD6ot/2CX79EeLZ+10wjZYJLAaADfvWFufvjAjKrQaMyepT5AUTEp9agXjdctqjtmEQL1
 pYz0Z8JZ3olw==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205377827"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="205377827"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:41:54 -0700
IronPort-SDR: BF46IkfbSUHlYCAFmOz21jprfTjVXYUqOpWqYPeAs+HC3Kx+Nf0IG7Kk/LJHhc+91BBl1a1tKU
 TJXj7omelRuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="553464031"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2021 09:41:54 -0700
Subject: [PATCH 0/4] selftests/vm/pkeys: Bug fixes and a new test
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        linuxram@us.ibm.com, sandipan@linux.ibm.com,
        akpm@linux-foundation.org, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        mpe@ellerman.id.au, mhocko@kernel.org, msuchanek@suse.de,
        shuah@kernel.org, x86@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 11 Jun 2021 09:41:53 -0700
Message-Id: <20210611164153.91B76FB8@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been a lot of activity on the x86 front around the XSAVE
architecture which is used to context-switch processor state (among
other things).  In addition, AMD has recently joined the protection
keys club by adding processor support for PKU.

The AMD implementation helped uncover a kernel bug around the PKRU
"init state", which actually applied to Intel's implementation but
was just harder to hit.  This series adds a test which is expected
to help find this class of bug both on AMD and Intel.  All the work
around pkeys on x86 also uncovered a few bugs in the selftest.

Any testing of this new code (especially from my powerpc friends)
would be appreciated.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Suchanek <msuchanek@suse.de>
Cc: Shuah Khan <shuah@kernel.org>
Cc: x86@kernel.org

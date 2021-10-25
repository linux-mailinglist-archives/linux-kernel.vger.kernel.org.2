Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD74393A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhJYK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 06:28:10 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34561 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232829AbhJYK2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:28:08 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CC99861EA191C;
        Mon, 25 Oct 2021 12:25:45 +0200 (CEST)
Message-ID: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
Date:   Mon, 25 Oct 2021 12:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: I got an IOMMU IO page fault. What to do now?
To:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     iommu@lists.linux-foundation.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        it+linux-iommu@molgen.mpg.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


On a Dell OptiPlex 5055, Linux 5.10.24 logged the IOMMU messages below. 
(GPU hang in amdgpu issue #1762 [1] might be related.)

     $ lspci -nn -s 05:00.0
     05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, 
Inc. [AMD/ATI] Oland [Radeon HD 8570 / R7 240/340 OEM] [1002:6611] (rev 87)
     $ dmesg
     […]
     [6318399.745242] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xfffffff0c0 flags=0x0020]
     [6318399.757283] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xfffffff7c0 flags=0x0020]
     [6318399.769154] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xffffffe0c0 flags=0x0020]
     [6318399.780913] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xfffffffec0 flags=0x0020]
     [6318399.792734] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xffffffe5c0 flags=0x0020]
     [6318399.804309] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xffffffd0c0 flags=0x0020]
     [6318399.816091] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xffffffecc0 flags=0x0020]
     [6318399.827407] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xffffffd3c0 flags=0x0020]
     [6318399.838708] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xffffffc0c0 flags=0x0020]
     [6318399.850029] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x000c address=0xffffffdac0 flags=0x0020]
     [6318399.861311] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffffc1c0 flags=0x0020]
     [6318399.872044] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffffc8c0 flags=0x0020]
     [6318399.882797] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffffb0c0 flags=0x0020]
     [6318399.893655] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffffcfc0 flags=0x0020]
     [6318399.904445] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffffb6c0 flags=0x0020]
     [6318399.915222] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffffa0c0 flags=0x0020]
     [6318399.925931] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffffbdc0 flags=0x0020]
     [6318399.936691] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffffa4c0 flags=0x0020]
     [6318399.947479] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffff90c0 flags=0x0020]
     [6318399.958270] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 
domain=0x000c address=0xffffffabc0 flags=0x0020]

As this is not reproducible, how would debugging go? (The system was 
rebooted in the meantime.) What options should be enabled, that next 
time the required information is logged, or what commands should I 
execute when the system is still in that state, so the bug (driver, 
userspace, …) can be pinpointed and fixed?


Kind regards,

Paul


[1]: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
      "Oland [Radeon HD 8570 / R7 240/340 OEM]: GPU hang"

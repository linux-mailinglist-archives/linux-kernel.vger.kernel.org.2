Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD923B23FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFWXlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:41:13 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:59824 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFWXlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:41:12 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8110292009C; Thu, 24 Jun 2021 01:38:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7DCE592009B;
        Thu, 24 Jun 2021 01:38:53 +0200 (CEST)
Date:   Thu, 24 Jun 2021 01:38:53 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] x86/PCI: SiS PIRQ router updates
Message-ID: <alpine.DEB.2.21.2106240047560.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Nikolai has observed the trigger mode not being fixed up once it has been 
incorrectly set by the BIOS for PCI devices, causing all kinds of usual 
issues.  As it turns out we don't have a PIRQ router defined for the 
SiS85C497 southbridge, which Nikolai's system uses, and which is different 
from the SiS85C503 southbridge we have support for.

 As we use the generic `sis' infix (capitalised or not) for the SiS85C503 
southbridge I have prepared this small patch series to first make the 
existing SiS program entities use a more specific `sis503' infix, and then
provide a suitable PIRQ router for the SiS85C497 device.

 Posted as an RFC at this stage as it still has to be verified.

 Nikolai, can you please give it a hit with the extra debug patch as 
requested in my other message?

  Maciej

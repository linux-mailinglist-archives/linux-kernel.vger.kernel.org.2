Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972BF361777
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbhDPCRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:17:20 -0400
Received: from nl101-3.vfemail.net ([149.210.219.33]:38345 "EHLO
        nl101-3.vfemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhDPCRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
        :to:cc:subject:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=2018; bh=sPy0NxsKGPgl
        wTY38mvRLqWSwJOlEQ0zIlv+0exAHp4=; b=CXcmsaj5zGUhppNE7lzk/1EWwvNs
        qY/LKkUB0p4s0FvhXuXJd/kkgH8Booo+mjhgblEsmtWTS7pq9WwBSPv12O8XPbuS
        N6VgrZLdYJJQwKzQZ5c3Ccp75/WLv3juXe6iKxNf7TF0o8ug6Yy7UHjNMuTV+KxP
        Kjl5LN1qHDkzaBo=
Received: (qmail 27897 invoked from network); 16 Apr 2021 02:16:30 -0000
Received: by simscan 1.4.0 ppid: 27874, pid: 27884, t: 0.2930s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 16 Apr 2021 02:16:30 -0000
Date:   Thu, 15 Apr 2021 22:16:26 -0400
From:   David Niklas <Hgntkwis@vfemail.net>
To:     linux-kernel@vger.kernel.org
Cc:     christian.koenig@amd.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David1.Zhou@amd.com
Subject: Re: [Regression] amdgpu driver broken on AMD HD7770 GHz edition.
Message-ID: <20210415221626.3a33787f@Zen-II-x12.niklas.com>
In-Reply-To: <20210415212508.7ef57d73@Zen-II-x12.niklas.com>
References: <20210415212508.7ef57d73@Zen-II-x12.niklas.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I forgot to give you a bug tracker in case you want one.
Here: https://bugzilla.kernel.org/show_bug.cgi?id=212691

Thanks,
David

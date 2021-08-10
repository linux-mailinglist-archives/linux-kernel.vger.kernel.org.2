Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C703E82CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhHJSSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbhHJSQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:16:01 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92281C08EB49
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:55:14 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a19so23357652qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ujERZL3nczYhkTqAmsJonW07k6KdMHOPpQXfTZtFsvw=;
        b=QzeIfjUyRpajSLoesvR8eLo4zvaNPi4Y8lwRQfUZTu5P6P501RUXq/C+0qWvATVhw+
         BAxuUo8M9o15KnIPC3Bpm9T1vU0IgqtcWYAm/wp7RKanSDwNPiHvDaBZGK7Yp2dinVn9
         ZwEx6xOWTSMVHLSyDQQTEEDY1lYZfIUM23uGNezyySszAHuKOp2B3r7c5xLuvYpAOmIr
         8kKVMbbSX5zQVLg4vl83iy3+ln7vzkTRkUnJimIaGxptAE5ayFKW3Qz95sDW5cpNEcgH
         H8rHmnzqm21X6aoVA1oHiPcRIv+SrWPyv2miin2Wt3pyuaTf70mZuRPhRH6sKvgNnGbe
         7ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ujERZL3nczYhkTqAmsJonW07k6KdMHOPpQXfTZtFsvw=;
        b=pZEcTwZDSddgN/SNSPzfVvFhPUTQTVfoUfRJc5DUFI5iaOwiY2kWE5s+eLrLUlU9b/
         78T8ehjLLbxu4FYHHMGwr+MJHio6pEC+INcHr7FVBG1bykj2CQOC0uVte2KaIjiTK46j
         LwzcKJJ7mQ3mAbSIzMFkyoHDoKgX320nPPdJy44u23isdVqgqXGZ6ZpRMXXHF7jb95ve
         165ePCr4PrvG+kX5J74sCImzXvXlYF2D4wbzsnFZAVYI1mXgNQ/QT66DlHOaeToPBxnN
         yaUbbVNC8n3ZaYOWLfXEZURRaAB+EQwNtvb81rKAhUVnh1HTyTGwfSfibaKDLdkVBwkK
         1MlA==
X-Gm-Message-State: AOAM530QdsbVmSsFwD6dCfxxLKDwGtvV44rR97cWiyS6nlm6n6+KHEFi
        5TvbVDdlvijsl0UozN3AIm4=
X-Google-Smtp-Source: ABdhPJxz+eB/6swjK2RVRU03W+MdIGDt8D1N2HTQrjPh2y+/5zKr3NQ05cIBhCGQ+/zAcjZvT/IN/A==
X-Received: by 2002:a37:a303:: with SMTP id m3mr28919010qke.299.1628618113603;
        Tue, 10 Aug 2021 10:55:13 -0700 (PDT)
Received: from localhost.localdomain ([130.44.160.152])
        by smtp.gmail.com with ESMTPSA id bi3sm9873244qkb.133.2021.08.10.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 10:55:13 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Tue, 10 Aug 2021 13:55:11 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Maurizio Lombardi <mlombard@redhat.com>, rppt@kernel.org,
        bp@alien8.de, tglx@linutronix.de, x86@kernel.org,
        pjones@redhat.com, konrad@kernel.org, george.kennedy@oracle.com,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] iscsi_ibft: fix crash due to KASLR physical memory
 remapping
Message-ID: <YRK9fxhyPgEzWKce@localhost.localdomain>
References: <20210729135250.32212-1-mlombard@redhat.com>
 <YRKwqAlgWVGVpEJv@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRKwqAlgWVGVpEJv@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:00:24PM +0100, Christoph Hellwig wrote:
> > Fix this bug by saving the address of the physical location
> > of the ibft; later the driver will use isa_bus_to_virt() to get
> > the correct virtual address.
> 
> That sound rather broken.  Why not save the physical address in
> find_ibft_region and then later ioremap that when a virtual address is
> needed like all other code accessing magic I/O memory?

That is kind of what he does. The physical address is saved as a global
static variable and also the physical address is memreserved. Then
later on the physical address is used to create the virtual address.

Or are you thinking of making the find_ibft_region reserve the physical
address, and _cache_ the physical address so there is no global
variable ?

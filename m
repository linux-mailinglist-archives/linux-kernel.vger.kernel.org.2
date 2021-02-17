Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E7331D389
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 02:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhBQBHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 20:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhBQBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 20:07:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D48C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 17:06:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e9so548219pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 17:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VpU8qAYD0HfOV0jRoZxTxXUNEpZbr3IDKBiNxw+6kmw=;
        b=hcBGgzS01cvj3tS1uU+Qlhb0PBxMUQN4G476DRnY6E4TanTlZqzBytvm3YxtC8XAhD
         Oggmw8J639+xVybtpjkc8Hf2nTKcZJuMp4QQaL6ubCoEwCkUt11OVSC+cEpG3ZV/H4gQ
         aThc8eKCVZoKPZa6OKXgGuuvo+/6fqs9YrF/JJ50XajCL57Ml/0ojj3onIapz/V6Msnp
         aFSMHvwvcbC+JfsmUSqztpcipzp2YJZ02my6HOd1FZXSfxjUj3kBoCrLNzhwFhGfH2mm
         CQ6Pq9315s7Pr3kOZ/qYHOFolLrdGvKYF+0aNSTKxt8ylCUQZO6T8rO2whGDBLJ8IxWi
         DLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VpU8qAYD0HfOV0jRoZxTxXUNEpZbr3IDKBiNxw+6kmw=;
        b=ouj+fLyAZuMHqoQd8qIAspXC6z7T0Gpqc0prXSrI9q7IMI5n3W7ItPoInWNeeAy0PA
         LGPSEazvIsoH6ybc0EQ4kK3R9SBCJ1TQwkiNtcQbJSjoC1Lu5UZj7lSpskEF3ysA96iK
         /cBApNjl6JaBP1i+ooQtT70pjBA2uJNF+Yb5Ad01YIY5w73RIerarbjm82yA7U/r7jq3
         2AWZX1Uk4eKqZENOzygophr8T1hZ4Nb/YNceczDHSRUbb/1CpirlX/PQaoLlDhhGzJvv
         J/RGpbjW7LQ/XrG7ULdrtp4AhLF0qfX7EtJLtekcLDVkfsX0P1ENcTROrAtSZ6zERaAL
         sELQ==
X-Gm-Message-State: AOAM5315IqUKW9d6BTsRo4E3FuynuN7PDtO4XLUFlys4BsD+Y2T+8/wo
        2JBStBN/ppiA/ndox48J4Z0XIA==
X-Google-Smtp-Source: ABdhPJymcHbHtR/rOaL0XXTVk3Pb4CatDHwqs5lW/oLEZk5H/tZBdT3zvB5dU9EN7jnhOe/nHALDLA==
X-Received: by 2002:a17:90a:ad97:: with SMTP id s23mr486958pjq.212.1613523998512;
        Tue, 16 Feb 2021 17:06:38 -0800 (PST)
Received: from google.com ([2620:15c:f:10:6948:259b:72c6:5517])
        by smtp.gmail.com with ESMTPSA id z12sm164166pjz.16.2021.02.16.17.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 17:06:37 -0800 (PST)
Date:   Tue, 16 Feb 2021 17:06:31 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, joro@8bytes.org, bp@suse.de,
        thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
Subject: Re: [PATCH v10 10/16] KVM: x86: Introduce KVM_GET_SHARED_PAGES_LIST
 ioctl
Message-ID: <YCxsFz2meMBdkn7t@google.com>
References: <cover.1612398155.git.ashish.kalra@amd.com>
 <7266edd714add8ec9d7f63eddfc9bbd4d789c213.1612398155.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7266edd714add8ec9d7f63eddfc9bbd4d789c213.1612398155.git.ashish.kalra@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021, Ashish Kalra wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> The ioctl is used to retrieve a guest's shared pages list.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>

AFAIK, Radim is no longer involved with KVM, and his RedHat email is bouncing.
Probably best to drop his Cc in future revisions.

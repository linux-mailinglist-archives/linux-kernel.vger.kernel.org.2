Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3123734781E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhCXMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233333AbhCXMRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616588226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9F49iv0iMvNhK2Ha5Psl89snw9CgCXbICGGoRQHqgo=;
        b=agjR4kAMkGySspKyhL8flrXd2Gx0ZFy6mZ1GNF0oy2a/SoDKfWuhZblDdTaN57Z2X5dc7I
        F9dLwAf1iHcBW0osNLpBY6glAZYKj0nkGH+Ls6Rvy3QTOS8U8ycbnyaS0TWsPYVUOC4dt7
        0SsacyKDJ91cmvgMMkFD6TaCN5UlHqc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-kDgVPmd1MdKZcBsZHF0VUg-1; Wed, 24 Mar 2021 08:17:03 -0400
X-MC-Unique: kDgVPmd1MdKZcBsZHF0VUg-1
Received: by mail-wr1-f71.google.com with SMTP id 9so994735wrb.16
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E9F49iv0iMvNhK2Ha5Psl89snw9CgCXbICGGoRQHqgo=;
        b=Y+wOJLVFlA5bUpwqeRfJqynRsq9O9u/cWcVyn6P0a/XbP2rpRVvQuYJF7VBjuC0uRa
         eaerYG/V4Xk9qF+OXPomFyIqI0Jxa8CKwYkdw+j8Olk8UDoK9fBPD1it9eTSaK3hz3Au
         BDhR7Mp3zWhSZd9Hycg4MhLoKvLojmr7bD2PJKfvhWaRWGcpe+zA29P+pqPr7gnLdiaO
         3pkIQjnvNt0WgbkOAHMJevBNzbxn2s3aex92T4TGBVEoyKygZUfPyXMKlGLP26Rqd7ZM
         SgVme3grG06refTFq++S6uUKtJHaEy6iKaOWdIkAyqA50OE6/JfEEfixMMlku1aj5IGv
         rg0Q==
X-Gm-Message-State: AOAM532f+VLzuMb5/UX9zXkX5CyBZuf2wNd6CJi+IYooS/99czOj2yQ9
        aSMTnGmZmCradg9H8g+Uy+Ev7P5ktV4PWb0NKNb6g0sag1zxAmvVgjUoLXA2kVtts9ZyvqyKltA
        ZqWHrYx+gR7rwBWLoiGLEnHAh
X-Received: by 2002:a1c:10f:: with SMTP id 15mr2732452wmb.14.1616588222692;
        Wed, 24 Mar 2021 05:17:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeb/ON+kOZdzKfxRLK6YPN7H/+pVhXU/ZCNGdjNz0SXLH6TmVovV6hD5q+z3+Sl9n5adX/sQ==
X-Received: by 2002:a1c:10f:: with SMTP id 15mr2732435wmb.14.1616588222507;
        Wed, 24 Mar 2021 05:17:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id c131sm2362100wma.37.2021.03.24.05.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 05:17:01 -0700 (PDT)
Subject: Re: [syzbot] possible deadlock in kvm_synchronize_tsc
To:     syzbot <syzbot+9a89b866d3fc11acc3b6@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
References: <00000000000099aa6805be432fce@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd9de982-e94d-163f-067b-d86d95e947a8@redhat.com>
Date:   Wed, 24 Mar 2021 13:17:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <00000000000099aa6805be432fce@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/21 08:24, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1c273e10 Merge tag 'zonefs-5.12-rc4' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1063d14ed00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
> dashboard link: https://syzkaller.appspot.com/bug?extid=9a89b866d3fc11acc3b6
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bf56f6d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174e36dcd00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9a89b866d3fc11acc3b6@syzkaller.appspotmail.com

#syz dup: possible deadlock in scheduler_tick


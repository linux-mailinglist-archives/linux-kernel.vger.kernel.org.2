Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE63827FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhEQJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhEQJNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:13:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E3C061761
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:12:26 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1liZI8-00AGhX-T1; Mon, 17 May 2021 11:12:00 +0200
Message-ID: <1f8289f84cd4dd9f440705d3ebab2c8a3e2e6a2c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 01/17] virtio_ring: Avoid reading unneeded used
 length
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 May 2021 11:11:59 +0200
In-Reply-To: <20210517090836.533-2-xieyongji@bytedance.com> (sfid-20210517_110907_205181_BA136748)
References: <20210517090836.533-1-xieyongji@bytedance.com>
         <20210517090836.533-2-xieyongji@bytedance.com>
         (sfid-20210517_110907_205181_BA136748)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-17 at 17:08 +0800, Xie Yongji wrote:
> If device driver doesn't need used length, it can pass a NULL
> len in virtqueue_get_buf()/virtqueue_get_buf_ctx().
> 

Well, actually, it can't right now?

You should probably rephrase this, saying something like

   Allow passing NULL to len in ... if the device driver doesn't need
   the length, and don't read it in that case.

or so?

>  Then
> we can avoid reading and validating the len value in used
> ring entries.

Not sure what that "validating" is about, I only see reading?

johannes


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5006E3117A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhBFAIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:08:10 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:57677 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhBENsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:48:11 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 81RclTJVeFFpm81RglH0Uh; Fri, 05 Feb 2021 14:46:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1612532809; bh=eeIQ3lc6028oLMlea4AHNdLl0tt2BQ1HMogC4rAypDI=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=QXVUNaAT1tII5aFDk+cPR8pJYdtQgXYC6klZDolwlsOsOcOtMcYruZwvaYPoLxCp3
         bfZGWpZWYMLUa1r+Vkit1r45mKmGycy0z9+BChbGO1uFFzTrsugaZQy5UkmiDPzfkN
         Qx4EL0yU37Li6HA4uSZQz+Lp8L0PcwHSrwMhaIiYhnoC5cqLFeiOMEYnIICROjpjGC
         mXwY9uy+oPn+F17WWxDL/TYwwwP74y1uMwirFXg0PJ6pw/TkooBsLoxhcQ0yDa0vZ6
         CyTlMqKIIJzmQEE35EygcZKFXjLxs8GChTlgkmbENglKUl9CAHKsO57ZCuuKQUp+Nw
         aO13Xc+6FR7bw==
Subject: Re: [PATCH v3 2/4] drm_dp_mst_topology: use correct AUX channel
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Sam McNally <sammc@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <20200923121320.v3.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
 <YBh9HvbIRF4zd+AK@intel.com> <2a7c2edc-b83c-dccf-487d-1415b4bc23ff@xs4all.nl>
 <CAJqEsoCOJmS5aVb5du09tXUi7UUKVBQDPe5KTdcBiDr8A7kSYA@mail.gmail.com>
 <YB1HBDEB5/fefQzi@intel.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c577f417-b6c2-6714-8c97-ec6d636bb3a7@xs4all.nl>
Date:   Fri, 5 Feb 2021 14:46:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YB1HBDEB5/fefQzi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfF/2LkHUBR6Sj5FcCmtu5nSjDtH0gXnDX48kOwSB2540xv2DzasTmniuBdVtNsBlQec0ezWIItZKJZVotxicsO8IKSyPnZpsIJauJsqzAvJDL62upT2c
 3nEQGLoRVxVe9PS4j5SXwaaEbtesNJksIRkjsdC5LZGKs80/IRoVWTdRzXRqtn2cD3f/1dbCwaVvWXNzv2G9EYv0e2mO4A7RgBwkncLqWc8W+/y+0gpFFk1E
 xCzTOOpZtwXm5xDH+kRAhQW9OesbT9rSKmjZU1rkPu3YPzYsb2X4b6T02rq8YwQk3lKLzwX8LjLcf4QvJVeyQOTKfXRS9KNt+wfvhcVJHpl3UpszBFZVjA+G
 6hT1EtSnM959b3M6T6cKpeY6jAbejDWyDJDOuDUWEOaHTu1/B7OT+vFTpHBpmizJS8NzussN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 14:24, Ville Syrjälä wrote:
> On Fri, Feb 05, 2021 at 04:17:51PM +1100, Sam McNally wrote:
>> On Thu, 4 Feb 2021 at 21:19, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>>
>>> On 01/02/2021 23:13, Ville Syrjälä wrote:
>>>> On Wed, Sep 23, 2020 at 12:13:53PM +1000, Sam McNally wrote:
>>>>> From: Hans Verkuil <hans.verkuil@cisco.com>
>>>>>
>>>>> For adapters behind an MST hub use the correct AUX channel.
>>>>>
>>>>> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
>>>>> [sammc@chromium.org: rebased, removing redundant changes]
>>>>> Signed-off-by: Sam McNally <sammc@chromium.org>
>>>>> ---
>>>>>
>>>>> (no changes since v1)
>>>>>
>>>>>  drivers/gpu/drm/drm_dp_mst_topology.c | 36 +++++++++++++++++++++++++++
>>>>>  1 file changed, 36 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
>>>>> index 15b6cc39a754..0d753201adbd 100644
>>>>> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
>>>>> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
>>>>> @@ -2255,6 +2255,9 @@ drm_dp_mst_topology_unlink_port(struct drm_dp_mst_topology_mgr *mgr,
>>>>>      drm_dp_mst_topology_put_port(port);
>>>>>  }
>>>>>
>>>>> +static ssize_t
>>>>> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg);
>>>>> +
>>>>>  static struct drm_dp_mst_port *
>>>>>  drm_dp_mst_add_port(struct drm_device *dev,
>>>>>                  struct drm_dp_mst_topology_mgr *mgr,
>>>>> @@ -2271,9 +2274,13 @@ drm_dp_mst_add_port(struct drm_device *dev,
>>>>>      port->port_num = port_number;
>>>>>      port->mgr = mgr;
>>>>>      port->aux.name = "DPMST";
>>>>> +    mutex_init(&port->aux.hw_mutex);
>>>>> +    mutex_init(&port->aux.cec.lock);
>>>>>      port->aux.dev = dev->dev;
>>>>>      port->aux.is_remote = true;
>>>>>
>>>>> +    port->aux.transfer = drm_dp_mst_aux_transfer;
>>>>> +
>>>>
>>>> This was supposed to be handled via higher levels checking for
>>>> is_remote==true.
>>>
>>> Ah, I suspect this patch can be dropped entirely: it predates commit 2f221a5efed4
>>> ("drm/dp_mst: Add MST support to DP DPCD R/W functions").
>>>
>>> It looks like that commit basically solved what this older patch attempts to do
>>> as well.
>>>
>>> Sam, can you test if it works without this patch?
>>
>> It almost just works; drm_dp_cec uses whether aux.transfer is non-null
>> to filter out non-DP connectors. Using aux.is_remote as another signal
>> indicating a DP connector seems plausible. We can drop this patch.
> 
> Why would anyone even call this stuff on a non-DP connector?
> And where did they even get the struct drm_dp_aux to do so?

This check came in with commit 5ce70c799ac2 ("drm_dp_cec: check that aux
has a transfer function"). It seems nouveau and amdgpu specific.

A better approach would be to fix those drivers to only call these cec
functions for DP outputs. I think I moved the test to drm_dp_cec.c primarily
for robustness (i.e. do nothing if called for a non-DP output). But that
might not be the right approach after all.

Regards,

	Hans

> 
>> Thanks all!
>>>
>>> Regards,
>>>
>>>         Hans
>>>
>>>>
>>>>>      /* initialize the MST downstream port's AUX crc work queue */
>>>>>      drm_dp_remote_aux_init(&port->aux);
>>>>>
>>>>> @@ -3503,6 +3510,35 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
>>>>>      return 0;
>>>>>  }
>>>>>
>>>>> +static ssize_t
>>>>> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
>>>>> +{
>>>>> +    struct drm_dp_mst_port *port =
>>>>> +            container_of(aux, struct drm_dp_mst_port, aux);
>>>>> +    int ret;
>>>>> +
>>>>> +    switch (msg->request & ~DP_AUX_I2C_MOT) {
>>>>> +    case DP_AUX_NATIVE_WRITE:
>>>>> +    case DP_AUX_I2C_WRITE:
>>>>> +    case DP_AUX_I2C_WRITE_STATUS_UPDATE:
>>>>> +            ret = drm_dp_send_dpcd_write(port->mgr, port, msg->address,
>>>>> +                                         msg->size, msg->buffer);
>>>>
>>>> That doesn't make sense to me. I2c writes and DPCD writes
>>>> are definitely not the same thing.
>>>>
>>>> aux->transfer is a very low level thing. I don't think it's the
>>>> correct level of abstraction for sideband.
>>>>
>>>>> +            break;
>>>>> +
>>>>> +    case DP_AUX_NATIVE_READ:
>>>>> +    case DP_AUX_I2C_READ:
>>>>> +            ret = drm_dp_send_dpcd_read(port->mgr, port, msg->address,
>>>>> +                                        msg->size, msg->buffer);
>>>>> +            break;
>>>>> +
>>>>> +    default:
>>>>> +            ret = -EINVAL;
>>>>> +            break;
>>>>> +    }
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>>  static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
>>>>>  {
>>>>>      if (dp_link_bw == 0 || dp_link_count == 0)
>>>>> --
>>>>> 2.28.0.681.g6f77f65b4e-goog
>>>>>
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>
>>>
> 


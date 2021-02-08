Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8BA3129B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 05:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBHESM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 23:18:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhBHERp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 23:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612757778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=163dsehELjqfTy3yraaw2TTJlJnhey0aJXrU0Gs1cr4=;
        b=HhM6iV2GPMK7Z/SPJP5Iddu63untBbhYooSBsBlhhxvE9QDwzAd3oiORqF5M0H++rUVvwj
        8W7EJJd+atZQKlmevUth4x9SLOvd5w4kP3HDhgTJt0UEBIgLoBFneVl3TZ3EnxXq5P+H81
        KOs/uGyLUTKve8BTdE9oZRWJTk0Tmic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-nt6rwihRPW6qP0WZNp1Rbg-1; Sun, 07 Feb 2021 23:16:16 -0500
X-MC-Unique: nt6rwihRPW6qP0WZNp1Rbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A896A80197A;
        Mon,  8 Feb 2021 04:16:15 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EED1761D31;
        Mon,  8 Feb 2021 04:16:06 +0000 (UTC)
Subject: Re: [PATCH V3 17/19] vdpa: set the virtqueue num during register
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-18-jasowang@redhat.com>
 <20210205102552-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d2c32306-d8f5-698e-b1f7-c382d3f4a29c@redhat.com>
Date:   Mon, 8 Feb 2021 12:16:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205102552-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/5 下午11:27, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2021 at 02:55:01PM +0800, Jason Wang wrote:
>> This patch delay the queue number setting to vDPA device
>> registering. This allows us to probe the virtqueue numbers between
>> device allocation and registering.
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Conflicts with other patches in the vhost tree.
> Can you rebase please?


Will do.

Thanks


>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_main.c   | 5 ++---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 ++---
>>   drivers/vdpa/vdpa.c               | 8 ++++----
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c  | 4 ++--
>>   include/linux/vdpa.h              | 7 +++----
>>   5 files changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index 8b4028556cb6..d65f3221d8ed 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -438,8 +438,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	}
>>   
>>   	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
>> -				    dev, &ifc_vdpa_ops,
>> -				    IFCVF_MAX_QUEUE_PAIRS * 2);
>> +				    dev, &ifc_vdpa_ops);
>>   	if (adapter == NULL) {
>>   		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
>>   		return -ENOMEM;
>> @@ -463,7 +462,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++)
>>   		vf->vring[i].irq = -EINVAL;
>>   
>> -	ret = vdpa_register_device(&adapter->vdpa);
>> +	ret = vdpa_register_device(&adapter->vdpa, IFCVF_MAX_QUEUE_PAIRS * 2);
>>   	if (ret) {
>>   		IFCVF_ERR(pdev, "Failed to register ifcvf to vdpa bus");
>>   		goto err;
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index f1d54814db97..a1b9260bf04d 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -1958,8 +1958,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>>   	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
>>   	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>>   
>> -	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>> -				 2 * mlx5_vdpa_max_qps(max_vqs));
>> +	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops);
>>   	if (IS_ERR(ndev))
>>   		return PTR_ERR(ndev);
>>   
>> @@ -1986,7 +1985,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>>   	if (err)
>>   		goto err_res;
>>   
>> -	err = vdpa_register_device(&mvdev->vdev);
>> +	err = vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
>>   	if (err)
>>   		goto err_reg;
>>   
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index a69ffc991e13..ba89238f9898 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -61,7 +61,6 @@ static void vdpa_release_dev(struct device *d)
>>    * initialized but before registered.
>>    * @parent: the parent device
>>    * @config: the bus operations that is supported by this device
>> - * @nvqs: number of virtqueues supported by this device
>>    * @size: size of the parent structure that contains private data
>>    *
>>    * Driver should use vdpa_alloc_device() wrapper macro instead of
>> @@ -72,7 +71,6 @@ static void vdpa_release_dev(struct device *d)
>>    */
>>   struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>>   					const struct vdpa_config_ops *config,
>> -					int nvqs,
>>   					size_t size)
>>   {
>>   	struct vdpa_device *vdev;
>> @@ -99,7 +97,6 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>>   	vdev->index = err;
>>   	vdev->config = config;
>>   	vdev->features_valid = false;
>> -	vdev->nvqs = nvqs;
>>   
>>   	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
>>   	if (err)
>> @@ -122,11 +119,14 @@ EXPORT_SYMBOL_GPL(__vdpa_alloc_device);
>>    * vdpa_register_device - register a vDPA device
>>    * Callers must have a succeed call of vdpa_alloc_device() before.
>>    * @vdev: the vdpa device to be registered to vDPA bus
>> + * @nvqs: number of virtqueues supported by this device
>>    *
>>    * Returns an error when fail to add to vDPA bus
>>    */
>> -int vdpa_register_device(struct vdpa_device *vdev)
>> +int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
>>   {
>> +	vdev->nvqs = nvqs;
>> +
>>   	return device_add(&vdev->dev);
>>   }
>>   EXPORT_SYMBOL_GPL(vdpa_register_device);
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 6a90fdb9cbfc..b129cb4dd013 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -357,7 +357,7 @@ static struct vdpasim *vdpasim_create(void)
>>   	else
>>   		ops = &vdpasim_net_config_ops;
>>   
>> -	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
>> +	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops);
>>   	if (!vdpasim)
>>   		goto err_alloc;
>>   
>> @@ -393,7 +393,7 @@ static struct vdpasim *vdpasim_create(void)
>>   	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
>>   
>>   	vdpasim->vdpa.dma_dev = dev;
>> -	ret = vdpa_register_device(&vdpasim->vdpa);
>> +	ret = vdpa_register_device(&vdpasim->vdpa, VDPASIM_VQ_NUM);
>>   	if (ret)
>>   		goto err_iommu;
>>   
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index 30bc7a7223bb..d9e9d17b9083 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -244,18 +244,17 @@ struct vdpa_config_ops {
>>   
>>   struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>>   					const struct vdpa_config_ops *config,
>> -					int nvqs,
>>   					size_t size);
>>   
>> -#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs)   \
>> +#define vdpa_alloc_device(dev_struct, member, parent, config)   \
>>   			  container_of(__vdpa_alloc_device( \
>> -				       parent, config, nvqs, \
>> +				       parent, config, \
>>   				       sizeof(dev_struct) + \
>>   				       BUILD_BUG_ON_ZERO(offsetof( \
>>   				       dev_struct, member))), \
>>   				       dev_struct, member)
>>   
>> -int vdpa_register_device(struct vdpa_device *vdev);
>> +int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
>>   void vdpa_unregister_device(struct vdpa_device *vdev);
>>   
>>   /**
>> -- 
>> 2.25.1


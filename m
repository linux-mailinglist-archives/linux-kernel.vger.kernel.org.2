Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10F233E14F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhCPWWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:22:44 -0400
Received: from foss.arm.com ([217.140.110.172]:37428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhCPWWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:22:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DBE8D6E;
        Tue, 16 Mar 2021 15:22:13 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 304133F718;
        Tue, 16 Mar 2021 15:22:11 -0700 (PDT)
Date:   Tue, 16 Mar 2021 22:22:00 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>, lukasz.luba@arm.com,
        james.quinlan@broadcom.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Guru Nagarajan <gurunagarajan@google.com>,
        Enrico Granata <egranata@google.com>
Subject: Re: [PATCH v7 25/38] iio/scmi: port driver to the new
 scmi_sensor_proto_ops interface
Message-ID: <20210316222132.GA6875@e120937-lin>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
 <20210316124903.35011-26-cristian.marussi@arm.com>
 <CA+=V6c08cVmsCV_sDn5CogzbyN5KyNKL=u+WkAE0cPz2fqPhjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=V6c08cVmsCV_sDn5CogzbyN5KyNKL=u+WkAE0cPz2fqPhjQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyoti,

On Tue, Mar 16, 2021 at 10:51:48AM -0700, Jyoti Bhayana wrote:
> Hi Christian,
> 
> Thanks for porting this driver to the new interface. I have two questions:
> 
> 1)  In the following code snippet, can the sensor_ops be made as part
> of struct scmi_iio_priv as scmi_protocol_handle is also part of that
> struct. Not sure if there are any particular reasons for having the
> protocol handle as part of the struct but the sensor_ops as global?
> 
> > +static const struct scmi_sensor_proto_ops *sensor_ops;
> >+
>  >.struct scmi_iio_priv {
> >-       struct scmi_handle *handle;
> >+       struct scmi_protocol_handle *ph;
> >      const struct scmi_sensor_info *sensor_info;
> >     struct iio_dev *indio_dev;
> 

So, the protocol_handle represents a reference to an instance of
the sensor protocol initialized against the specific SCMI platform
instance referred by the handle provided in the probe: so that if you
should have multiple SCMI platforms defined in the DT, this driver
(as all SCMI drivers) would be probed multiple times each time with a
different handle and it would obtain a different protocol_handle each
time it issued a probe() => devm_protocol_get().
For this reason the obtained protocol_handle cannot be kept as a global
and it seemed a good fit to stay in the existent scmi_iio_priv.

On the other side, the sensor_ops are just plain function pointers (as
they were before), so on any possible probe they are returned the same
(for the same proto): it is indeed the specified protocol_handle used
at invocation time that determines against which instance they actually
operates (if multiple instances present at all); so the sensor_ops seemed
a good fit for a global, also because that way tehy are more easily
accessible throughout the driver.

Does it make sense ?

> 2)  Looks like the event notifier registration is SCMI device managed
> and that's why there is no call to unregister. I am assuming that you
> have tested the logic of inserting the module, removing it and then
> again inserting it to make sure that when the event is registered a
> second time , the logic is all good.
> 
>    > ret = handle->notify_ops->devm_event_notifier_register(sdev,
> 

Sure, I tested load/unload in general for also other SCMI drivers just
to be sure not to have broken completely the world with this series.

Please find below a load/unload/load sequence for scmi_iio.ko.
(there are 2 emulated sensors, only one is timestamped)

Thanks

Cristian

---

(debian-arm64)root@debarm64:~# ls /sys/bus/iio/devices/
(debian-arm64)root@debarm64:~# insmod ./scmi_iio.ko
(debian-arm64)root@debarm64:~# ls /sys/bus/iio/devices/
iio:device0  iio:device1
(debian-arm64)root@debarm64:~# cat /sys/bus/iio/devices/iio\:device0/name
emu8_accel
(debian-arm64)root@debarm64:~# cat /sys/bus/iio/devices/iio\:device1/name
emu9_gyro
(debian-arm64)root@debarm64:~# /root/iio_generic_buffer -a -c -1 -g -l 100 -N 0
iio device number being used is 0
trigger-less mode selected
Enabling all channels
Enabling: in_accel_x_en
Enabling: in_accel_z_en
Enabling: in_timestamp_en
Enabling: in_accel_y_en
-7737 -7729 -7721 16725578467193651200.000000
-7736 -7728 -7720 16725578467193651200.000000
-7735 -7727 -7719 16725578467193651200.000000
-7734 -7726 -7718 16725578467193651200.000000
-7733 -7725 -7717 16725578467193651200.000000
-7732 -7724 -7716 16725578467193651200.000000
-7731 -7723 -7715 16725578467193651200.000000
-7730 -7722 -7714 17725578795097784320.000000
-7729 -7721 -7713 17725578795097784320.000000
-7728 -7720 -7712 17725578795097784320.000000
-7727 -7719 -7711 17725578795097784320.000000
-7726 -7718 -7710 17725578795097784320.000000
-7725 -7717 -7709 17725578795097784320.000000
-7724 -7716 -7708 17725578795097784320.000000
-7723 -7715 -7707 17725578795097784320.000000
-7722 -7714 -7706 17725578795097784320.000000
-7721 -7713 -7705 17725578795097784320.000000
^CCaught signal 2
Disabling: in_accel_x_en
Disabling: in_accel_z_en
Disabling: in_timestamp_en
Disabling: in_accel_y_en
(debian-arm64)root@debarm64:~# /root/iio_generic_buffer -a -c -1 -g -l 100 -N 1
iio device number being used is 1
trigger-less mode selected
Enabling all channels
Enabling: in_accel_x_en
Enabling: in_accel_z_en
Enabling: in_timestamp_en
Enabling: in_accel_y_en
-3583 -3574 -3565 270679244800.000000
-3582 -3573 -3564 270780203008.000000
-3581 -3572 -3563 270880358400.000000
-3580 -3571 -3562 270980431872.000000
-3579 -3570 -3561 271080521728.000000
-3578 -3569 -3560 271180611584.000000
-3577 -3568 -3559 271280685056.000000
-3576 -3567 -3558 271380774912.000000
-3575 -3566 -3557 271480848384.000000
-3574 -3565 -3556 271580938240.000000
-3573 -3564 -3555 271681028096.000000
-3572 -3563 -3554 271781101568.000000
-3571 -3562 -3553 271881191424.000000
-3570 -3561 -3552 271981264896.000000
-3569 -3560 -3551 272081354752.000000
^CCaught signal 2
Disabling: in_accel_x_en
Disabling: in_accel_z_en
Disabling: in_timestamp_en
Disabling: in_accel_y_en
(debian-arm64)root@debarm64:~#
(debian-arm64)root@debarm64:~# rmmod ./scmi_iio.ko
(debian-arm64)root@debarm64:~# ls /sys/bus/iio/devices/
(debian-arm64)root@debarm64:~# insmod ./scmi_iio.ko
(debian-arm64)root@debarm64:~# ls /sys/bus/iio/devices/
iio:device0  iio:device1
(debian-arm64)root@debarm64:~# /root/iio_generic_buffer -a -c -1 -g -l 100 -N 0
iio device number being used is 0
trigger-less mode selected
Enabling all channels
Enabling: in_accel_x_en
Enabling: in_accel_z_en
Enabling: in_timestamp_en
Enabling: in_accel_y_en
-7308 -7300 -7292 4385346052291559424.000000
-7307 -7299 -7291 4385346052291559424.000000
-7306 -7298 -7290 4385346052291559424.000000
-7305 -7297 -7289 4385346052291559424.000000
-7304 -7296 -7288 4385346052291559424.000000
-7303 -7295 -7287 4385346052291559424.000000
-7302 -7294 -7286 4385346052291559424.000000
-7301 -7293 -7285 5385346380195692544.000000
-7300 -7292 -7284 5385346380195692544.000000
-7299 -7291 -7283 5385346380195692544.000000
-7298 -7290 -7282 5385346380195692544.000000
-7297 -7289 -7281 5385346380195692544.000000
-7296 -7288 -7280 5385346380195692544.000000
^CCaught signal 2
Disabling: in_accel_x_en
Disabling: in_accel_z_en
Disabling: in_timestamp_en
Disabling: in_accel_y_en
(debian-arm64)root@debarm64:~# /root/iio_generic_buffer -a -c -1 -g -l 100 -N 1
iio device number being used is 1
trigger-less mode selected
Enabling all channels
Enabling: in_accel_x_en
Enabling: in_accel_z_en
Enabling: in_timestamp_en
Enabling: in_accel_y_en
-3161 -3152 -3143 312944197632.000000
-3160 -3151 -3142 313044303872.000000
-3159 -3150 -3141 313144377344.000000
-3158 -3149 -3140 313244483584.000000
-3157 -3148 -3139 313344851968.000000
-3156 -3147 -3138 313445023744.000000
-3155 -3146 -3137 313545097216.000000
-3154 -3145 -3136 313645465600.000000
-3153 -3144 -3135 313745604608.000000
-3152 -3143 -3134 313845710848.000000
-3151 -3142 -3133 313945784320.000000
-3150 -3141 -3132 314045890560.000000
-3149 -3140 -3131 314145964032.000000
-3148 -3139 -3130 314246070272.000000
-3147 -3138 -3129 314346143744.000000
-3146 -3137 -3128 314446249984.000000
-3145 -3136 -3127 314546618368.000000
-3144 -3135 -3126 314647052288.000000
^CCaught signal 2
Disabling: in_accel_x_en
Disabling: in_accel_z_en
Disabling: in_timestamp_en
Disabling: in_accel_y_en

> Thanks,
> Jyoti
> 
> On Tue, Mar 16, 2021 at 5:50 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Port driver to the new SCMI Sensor interface based on protocol handles
> > and common devm_get_ops().
> >
> > Cc: Jyoti Bhayana <jbhayana@google.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/iio/common/scmi_sensors/scmi_iio.c | 91 ++++++++++------------
> >  1 file changed, 41 insertions(+), 50 deletions(-)
> >
> > diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > index 872d87ca6256..b4bdc3f3a946 100644
> > --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> > +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > @@ -21,8 +21,10 @@
> >
> >  #define SCMI_IIO_NUM_OF_AXIS 3
> >
> > +static const struct scmi_sensor_proto_ops *sensor_ops;
> > +
> >  struct scmi_iio_priv {
> > -       struct scmi_handle *handle;
> > +       struct scmi_protocol_handle *ph;
> >         const struct scmi_sensor_info *sensor_info;
> >         struct iio_dev *indio_dev;
> >         /* adding one additional channel for timestamp */
> > @@ -82,7 +84,6 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
> >  static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> >  {
> >         struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > -       u32 sensor_id = sensor->sensor_info->id;
> >         u32 sensor_config = 0;
> >         int err;
> >
> > @@ -92,27 +93,11 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> >
> >         sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> >                                     SCMI_SENS_CFG_SENSOR_ENABLE);
> > -
> > -       err = sensor->handle->notify_ops->register_event_notifier(sensor->handle,
> > -                       SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > -                       &sensor_id, &sensor->sensor_update_nb);
> > -       if (err) {
> > -               dev_err(&iio_dev->dev,
> > -                       "Error in registering sensor update notifier for sensor %s err %d",
> > -                       sensor->sensor_info->name, err);
> > -               return err;
> > -       }
> > -
> > -       err = sensor->handle->sensor_ops->config_set(sensor->handle,
> > -                       sensor->sensor_info->id, sensor_config);
> > -       if (err) {
> > -               sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> > -                               SCMI_PROTOCOL_SENSOR,
> > -                               SCMI_EVENT_SENSOR_UPDATE, &sensor_id,
> > -                               &sensor->sensor_update_nb);
> > +       err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
> > +                                    sensor_config);
> > +       if (err)
> >                 dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
> >                         sensor->sensor_info->name, err);
> > -       }
> >
> >         return err;
> >  }
> > @@ -120,25 +105,13 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> >  static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
> >  {
> >         struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > -       u32 sensor_id = sensor->sensor_info->id;
> >         u32 sensor_config = 0;
> >         int err;
> >
> >         sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> >                                     SCMI_SENS_CFG_SENSOR_DISABLE);
> > -
> > -       err = sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> > -                       SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > -                       &sensor_id, &sensor->sensor_update_nb);
> > -       if (err) {
> > -               dev_err(&iio_dev->dev,
> > -                       "Error in unregistering sensor update notifier for sensor %s err %d",
> > -                       sensor->sensor_info->name, err);
> > -               return err;
> > -       }
> > -
> > -       err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
> > -                                                    sensor_config);
> > +       err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
> > +                                    sensor_config);
> >         if (err) {
> >                 dev_err(&iio_dev->dev,
> >                         "Error in disabling sensor %s with err %d",
> > @@ -161,8 +134,8 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
> >         u32 sensor_config;
> >         char buf[32];
> >
> > -       int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> > -                       sensor->sensor_info->id, &sensor_config);
> > +       int err = sensor_ops->config_get(sensor->ph, sensor->sensor_info->id,
> > +                                        &sensor_config);
> >         if (err) {
> >                 dev_err(&iio_dev->dev,
> >                         "Error in getting sensor config for sensor %s err %d",
> > @@ -208,8 +181,8 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
> >         sensor_config |=
> >                 FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
> >
> > -       err = sensor->handle->sensor_ops->config_set(sensor->handle,
> > -                       sensor->sensor_info->id, sensor_config);
> > +       err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
> > +                                    sensor_config);
> >         if (err)
> >                 dev_err(&iio_dev->dev,
> >                         "Error in setting sensor update interval for sensor %s value %u err %d",
> > @@ -274,8 +247,8 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
> >         u32 sensor_config;
> >         int mult;
> >
> > -       int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> > -                       sensor->sensor_info->id, &sensor_config);
> > +       int err = sensor_ops->config_get(sensor->ph, sensor->sensor_info->id,
> > +                                        &sensor_config);
> >         if (err) {
> >                 dev_err(&iio_dev->dev,
> >                         "Error in getting sensor config for sensor %s err %d",
> > @@ -542,15 +515,17 @@ static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> >         return 0;
> >  }
> >
> > -static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> > -                                        struct scmi_handle *handle,
> > -                                        const struct scmi_sensor_info *sensor_info)
> > +static struct iio_dev *
> > +scmi_alloc_iiodev(struct scmi_device *sdev, struct scmi_protocol_handle *ph,
> > +                 const struct scmi_sensor_info *sensor_info)
> >  {
> >         struct iio_chan_spec *iio_channels;
> >         struct scmi_iio_priv *sensor;
> >         enum iio_modifier modifier;
> >         enum iio_chan_type type;
> >         struct iio_dev *iiodev;
> > +       struct device *dev = &sdev->dev;
> > +       const struct scmi_handle *handle = sdev->handle;
> >         int i, ret;
> >
> >         iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> > @@ -560,7 +535,7 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> >         iiodev->modes = INDIO_DIRECT_MODE;
> >         iiodev->dev.parent = dev;
> >         sensor = iio_priv(iiodev);
> > -       sensor->handle = handle;
> > +       sensor->ph = ph;
> >         sensor->sensor_info = sensor_info;
> >         sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
> >         sensor->indio_dev = iiodev;
> > @@ -595,6 +570,17 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> >                                           sensor_info->axis[i].id);
> >         }
> >
> > +       ret = handle->notify_ops->devm_event_notifier_register(sdev,
> > +                               SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > +                               &sensor->sensor_info->id,
> > +                               &sensor->sensor_update_nb);
> > +       if (ret) {
> > +               dev_err(&iiodev->dev,
> > +                       "Error in registering sensor update notifier for sensor %s err %d",
> > +                       sensor->sensor_info->name, ret);
> > +               return ERR_PTR(ret);
> > +       }
> > +
> >         scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> >         iiodev->channels = iio_channels;
> >         return iiodev;
> > @@ -604,24 +590,29 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
> >  {
> >         const struct scmi_sensor_info *sensor_info;
> >         struct scmi_handle *handle = sdev->handle;
> > +       struct scmi_protocol_handle *ph;
> >         struct device *dev = &sdev->dev;
> >         struct iio_dev *scmi_iio_dev;
> >         u16 nr_sensors;
> >         int err = -ENODEV, i;
> >
> > -       if (!handle || !handle->sensor_ops) {
> > +       if (!handle)
> > +               return -ENODEV;
> > +
> > +       sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
> > +       if (IS_ERR(sensor_ops)) {
> >                 dev_err(dev, "SCMI device has no sensor interface\n");
> > -               return -EINVAL;
> > +               return PTR_ERR(sensor_ops);
> >         }
> >
> > -       nr_sensors = handle->sensor_ops->count_get(handle);
> > +       nr_sensors = sensor_ops->count_get(ph);
> >         if (!nr_sensors) {
> >                 dev_dbg(dev, "0 sensors found via SCMI bus\n");
> >                 return -ENODEV;
> >         }
> >
> >         for (i = 0; i < nr_sensors; i++) {
> > -               sensor_info = handle->sensor_ops->info_get(handle, i);
> > +               sensor_info = sensor_ops->info_get(ph, i);
> >                 if (!sensor_info) {
> >                         dev_err(dev, "SCMI sensor %d has missing info\n", i);
> >                         return -EINVAL;
> > @@ -636,7 +627,7 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
> >                     sensor_info->axis[0].type != RADIANS_SEC)
> >                         continue;
> >
> > -               scmi_iio_dev = scmi_alloc_iiodev(dev, handle, sensor_info);
> > +               scmi_iio_dev = scmi_alloc_iiodev(sdev, ph, sensor_info);
> >                 if (IS_ERR(scmi_iio_dev)) {
> >                         dev_err(dev,
> >                                 "failed to allocate IIO device for sensor %s: %ld\n",
> > --
> > 2.17.1
> >
